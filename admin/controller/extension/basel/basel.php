<?php
ini_set('display_errors', 1);

ini_set('display_startup_errors', 1);

error_reporting(E_ALL);
class ControllerExtensionBaselBasel extends Controller
{

    private $error = array();
    private $store_id = 0;

    public function index()
    {

        if ((float) VERSION >= 3.0) {
            $model_module_load = 'setting/module';
            $model_module_path = 'model_setting_module';
            $token_prefix = 'user_token';
        } else {
            $model_module_load = 'extension/module';
            $model_module_path = 'model_extension_module';
            $token_prefix = 'token';
        }

        // Set store id first
        if (isset($this->request->get['store_id'])) {
            $data['store_id'] = $this->request->get['store_id'];
        } else if (isset($this->request->post['store_id'])) {
            $data['store_id'] = $this->request->post['store_id'];
        } else {
            $data['store_id'] = 0;
        }

        $this->store_id = $data['store_id'];

        // Check if import demo store
        if (isset($this->request->get['import_demo']) && ($this->request->server['REQUEST_METHOD'] != 'POST') && $this->validate()) {
            $this->load->model('extension/basel/demo_stores/' . $this->request->get['import_demo'] . '/installer');
            $selected_store = $this->request->get['import_demo'];
            $path = 'model_extension_basel_demo_stores_' . $selected_store . '_installer';
            $this->$path->demoSetup();
        }

        $this->document->addStyle('view/javascript/basel/basel_panel.css');
        $this->document->addScript('view/javascript/basel/js/bootstrap-colorpicker.min.js');
        $this->document->addStyle('view/javascript/basel/css/bootstrap-colorpicker.min.css');
        $this->document->addStyle('view/javascript/basel/icons_list/fonts/style.css');

        $this->load->language('basel/basel');

        $this->load->model('setting/setting');
        $this->load->model('extension/basel/basel');

        $this->load->model('localisation/language');

        $data['languages'] = $this->model_localisation_language->getLanguages();

        $data['text_confirm'] = $this->language->get('text_confirm');
        $this->document->setTitle($this->language->get('heading_title'));

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', $token_prefix . '=' . $this->session->data[$token_prefix], true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/basel/basel', $token_prefix . '=' . $this->session->data[$token_prefix], true)
        );

        $data['token'] = $this->session->data[$token_prefix];

        // Success and Warning messages
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }

        // Language strings
        $data['button_add'] = $this->language->get('button_add');
        $data['button_remove'] = $this->language->get('button_remove');
        $data['error_permission'] = $this->language->get('error_permission');

        // Data strings
        $data['basel_theme_version'] = $this->getConfig('basel_theme_version');
        $data['theme_default_directory'] = $this->getConfig('theme_default_directory');

        // List Mega Menu Modules
        $this->load->model($model_module_load);
        $data['menu_modules'] = array();
        $menu_modules = $this->$model_module_path->getModulesByCode('basel_megamenu');
        foreach ($menu_modules as $menu_module) {
            $data['menu_modules'][] = array(
                'name' => strip_tags($menu_module['name']),
                'module_id' => $menu_module['module_id']
            );
        }

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            // Contacts - save to main config, not to basel

            // Phone and email - simple config update
            if (isset($this->request->post['settings']['basel']['main_phone'])) {
                $value = $this->request->post['settings']['basel']['main_phone'];
                $existing_value = $this->model_setting_setting->getSettingValue('config_telephone', $this->store_id);

                if (!is_null($existing_value)) {
                    $this->model_setting_setting->editSettingValue('config', 'config_telephone', $value, $this->store_id);
                } else {
                    $this->model_extension_basel_basel->addSettingValue('config', 'config_telephone', $value, $this->store_id);
                }
            }

            if (isset($this->request->post['settings']['basel']['main_email'])) {
                $value = $this->request->post['settings']['basel']['main_email'];
                $existing_value = $this->model_setting_setting->getSettingValue('config_email', $this->store_id);

                if (!is_null($existing_value)) {
                    $this->model_setting_setting->editSettingValue('config', 'config_email', $value, $this->store_id);
                } else {
                    $this->model_extension_basel_basel->addSettingValue('config', 'config_email', $value, $this->store_id);
                }
            }

            // Address and working hours - also sync with config_langdata
            if (isset($this->request->post['settings']['basel']['main_address'])) {
                $this->model_extension_basel_basel->updateContactSetting('config_address', 'address', $this->request->post['settings']['basel']['main_address'], $this->store_id);
            }

            if (isset($this->request->post['settings']['basel']['main_working_hours'])) {
                $this->model_extension_basel_basel->updateContactSetting('config_open', 'open', $this->request->post['settings']['basel']['main_working_hours'], $this->store_id);
            }


            // Added to delete basel fonts from database when they are completely deleted
            if (empty($this->request->post['settings']['basel']['basel_fonts'])) {
                $this->request->post['settings']['basel']['basel_fonts'] = array();
            }
            // Added to delete basel footer columns from database when they are completely deleted
            if (empty($this->request->post['settings']['basel']['basel_footer_columns'])) {
                $this->request->post['settings']['basel']['basel_footer_columns'] = array();
            }
            // Added to delete basel header links from database when they are completely deleted
            if (empty($this->request->post['settings']['basel']['basel_links'])) {
                $this->request->post['settings']['basel']['basel_links'] = array();
            }

            foreach ($this->request->post['settings'] as $code => $setting_data) {
                foreach ($setting_data as $key => $value) {
                    // Skip main contact fields - they are saved to config, not basel
                    if (in_array($key, ['main_phone', 'main_address', 'main_email', 'main_working_hours'])) {
                        continue;
                    }

                    $setting_value = $this->model_extension_basel_basel->getSettingValue($key, $data['store_id']);

                    if (!empty($setting_value)) {
                        $this->model_setting_setting->editSettingValue($code, $key, $value, $data['store_id']);
                    } else {
                        $this->db->query("DELETE FROM " . DB_PREFIX . "setting "
                            . "WHERE store_id = '" . (int) $data['store_id'] . "' "
                            . "AND `key` = '" . $key . "' "
                            . "AND `code` = '" . $this->db->escape($code) . "'");

                        if (!is_array($value)) {
                            $this->db->query("INSERT INTO " . DB_PREFIX . "setting SET "
                                . "store_id = '" . (int) $data['store_id'] . "', "
                                . "`code` = '" . $this->db->escape($code) . "', "
                                . "`key` = '" . $this->db->escape($key) . "', "
                                . "`value` = '" . $this->db->escape($value) . "'");
                        } else {
                            $this->db->query("INSERT INTO " . DB_PREFIX . "setting SET "
                                . "store_id = '" . (int) $data['store_id'] . "', "
                                . "`code` = '" . $this->db->escape($code) . "', "
                                . "`key` = '" . $this->db->escape($key) . "', "
                                . "`value` = '" . $this->db->escape(json_encode($value, true)) . "', "
                                . "serialized = '1'");
                        }
                    }
                }
            }

            $this->session->data['success'] = $this->language->get('text_success');

            // Clear caches
            $this->cache->delete('config.store_' . (int)$this->store_id);
            if ($this->store_id == 0) {
                $this->cache->delete('config');
            }
            $this->cache->delete('basel_mandatory_css_store_' . $data['store_id']);
            $this->cache->delete('basel_styles_cache_store_' . $data['store_id']);
            $this->cache->delete('basel_fonts_cache_store_' . $data['store_id']);

            $this->response->redirect($this->url->link('extension/basel/basel', $token_prefix . '=' . $this->session->data[$token_prefix] . '&store_id=' . (int) $data['store_id'], true));
        }

        // Fonts
        $basel_fonts_database = $this->getConfig('basel_fonts');

        if (isset($this->request->post['basel_fonts'])) {
            $data['basel_fonts'] = $this->request->post['basel_fonts'];
        } elseif (!empty($basel_fonts_database)) {
            $basel_fonts = $basel_fonts_database;
        } else {
            $basel_fonts = array();
        }

        $data['basel_fonts'] = array();
        if ($basel_fonts) {
            foreach ($basel_fonts as $basel_font) {
                $data['basel_fonts'][] = array(
                    'import' => $basel_font['import'],
                    'name' => $basel_font['name']
                );
            }
        }

        // System Fonts //
        $data['system_fonts'][] = array();
        $data['system_fonts'] = array(
            "Arial, Helvetica Neue, Helvetica, sans-serif" => "Arial",
            "Comic Sans MS, Comic Sans MS, cursive" => "Comic sans",
            "Courier New, Courier New, monospace" => "Courier New",
            "Georgia, Times, Times New Roman, serif" => "Georgia",
            "Impact, Charcoal, sans-serif" => "Impact",
            "Lucida Sans Typewriter, Lucida Console, Monaco, Bitstream Vera Sans Mono, monospace" => "Lucida Sans Typewriter",
            "Palatino, Palatino Linotype, Palatino LT STD, Book Antiqua, Georgia, serif" => "Palatino Linotype",
            "Tahoma, Verdana, Segoe, sans-serif" => "Tahoma",
            "Times New Roman, Times, Baskerville, Georgia, serif" => "Times New Roman",
            "Trebuchet MS, Lucida Grande, Lucida Sans Unicode, Lucida Sans, Tahoma, sans-serif" => "Trebuchet",
            "Verdana, Geneva, sans-serif" => "Verdana",
            "Phenomena, sans-serif" => "Phenomena"
        );


        // Images
        $this->load->model('tool/image');

        if (isset($this->request->post['basel_popup_note_img']) && is_file(DIR_IMAGE . $this->request->post['basel_popup_note_img'])) {
            $data['popup_thumb'] = $this->model_tool_image->resize($this->request->post['basel_popup_note_img'], 100, 100);
        } elseif ($this->getConfig('basel_popup_note_img') && is_file(DIR_IMAGE . $this->getConfig('basel_popup_note_img'))) {
            $data['popup_thumb'] = $this->model_tool_image->resize($this->getConfig('basel_popup_note_img'), 100, 100);
        } else {
            $data['popup_thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
        }

        if (isset($this->request->post['basel_bc_bg_img']) && is_file(DIR_IMAGE . $this->request->post['basel_bc_bg_img'])) {
            $data['bc_thumb'] = $this->model_tool_image->resize($this->request->post['basel_bc_bg_img'], 100, 100);
        } elseif ($this->getConfig('basel_bc_bg_img') && is_file(DIR_IMAGE . $this->getConfig('basel_bc_bg_img'))) {
            $data['bc_thumb'] = $this->model_tool_image->resize($this->getConfig('basel_bc_bg_img'), 100, 100);
        } else {
            $data['bc_thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
        }

        if (isset($this->request->post['basel_body_bg_img']) && is_file(DIR_IMAGE . $this->request->post['basel_body_bg_img'])) {
            $data['body_thumb'] = $this->model_tool_image->resize($this->request->post['basel_body_bg_img'], 100, 100);
        } elseif ($this->getConfig('basel_body_bg_img') && is_file(DIR_IMAGE . $this->getConfig('basel_body_bg_img'))) {
            $data['body_thumb'] = $this->model_tool_image->resize($this->getConfig('basel_body_bg_img'), 100, 100);
        } else {
            $data['body_thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
        }

        if (isset($this->request->post['basel_payment_img']) && is_file(DIR_IMAGE . $this->request->post['basel_payment_img'])) {
            $data['payment_thumb'] = $this->model_tool_image->resize($this->request->post['basel_popup_note_img'], 100, 100);
        } elseif ($this->getConfig('basel_payment_img') && is_file(DIR_IMAGE . $this->getConfig('basel_payment_img'))) {
            $data['payment_thumb'] = $this->model_tool_image->resize($this->getConfig('basel_payment_img'), 100, 100);
        } else {
            $data['payment_thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
        }

        $data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);


        // Variables
        $codes = array();

        $codes['config'] = array(
            'config_theme'
        );

        $codes['theme_default'] = array(
            'theme_default_directory',
            'theme_default_product_limit',
            'theme_default_product_description_length',
            'theme_default_image_category_width',
            'theme_default_image_category_height',
            'theme_default_image_thumb_width',
            'theme_default_image_thumb_height',
            'theme_default_image_popup_width',
            'theme_default_image_popup_height',
            'theme_default_image_product_width',
            'theme_default_image_product_height',
            'theme_default_image_additional_width',
            'theme_default_image_additional_height',
            'theme_default_image_related_width',
            'theme_default_image_related_height',
            'theme_default_image_compare_width',
            'theme_default_image_compare_height',
            'theme_default_image_wishlist_width',
            'theme_default_image_wishlist_height',
            'theme_default_image_cart_width',
            'theme_default_image_cart_height',
            'theme_default_image_location_width',
            'theme_default_image_location_height',
        );

        $codes['basel_version'] = array(
            'basel_theme_version'
        );

        $codes['basel'] = array(
            'basel_header',
            'use_custom_links',
            'basel_list_style',
            'primary_menu',
            'secondary_menu',
            'basel_links',
            'basel_promo0',
            'basel_promo',
            'basel_promo2',
            'top_line_style',
            'top_line_width',
            'top_line_height',
            'main_header_width',
            'main_header_height',
            'main_header_height_mobile',
            'main_header_height_sticky',
            'menu_height_normal',
            'menu_height_sticky',
            'logo_maxwidth',
            'main_menu_align',
            'header_login',
            'header_search',
            'header_phone',
            'basel_titles_listings',
            'basel_titles_product',
            'basel_titles_account',
            'basel_titles_checkout',
            'basel_titles_contact',
            'basel_titles_blog',
            'basel_titles_default',
            'basel_back_btn',
            'product_layout',
            'meta_description_status',
            'basel_hover_zoom',
            'full_width_tabs',
            'product_tabs_style',
            'basel_share_btn',
            'catalog_mode',
            'basel_cart_action',
            'wishlist_status',
            'basel_wishlist_action',
            'compare_status',
            'basel_compare_action',
            'quickview_status',
            'ex_tax_status',
            'basel_list_style',
            'countdown_status',
            'items_mobile_fw',
            'category_thumb_status',
            'category_subs_status',
            'basel_subs_grid',
            'basel_prod_grid',
            'newlabel_status',
            'stock_badge_status',
            'salebadge_status',
            'product_question_status',
            'questions_per_page',
            'questions_new_status',
            'basel_rel_prod_grid',
            'product_page_countdown',
            'basel_cut_names',
            'overwrite_footer_links',
            'footer_block_1',
            'footer_block_2',
            'footer_infoline_1',
            'footer_infoline_2',
            'footer_infoline_3',
            'basel_payment_img',
            'footer_block_title',
            'basel_footer_columns',
            'basel_copyright',
            'basel_popup_note_status',
            'basel_popup_note_once',
            'basel_popup_note_home',
            'basel_popup_note_img',
            'basel_popup_note_title',
            'basel_popup_note_block',
            'basel_popup_note_delay',
            'basel_popup_note_w',
            'basel_popup_note_h',
            'basel_popup_note_m',
            'basel_cookie_bar_status',
            'basel_cookie_bar_url',
            'basel_top_promo_status',
            'basel_top_promo_width',
            'basel_top_promo_close',
            'basel_top_promo_align',
            'basel_top_promo_text',
            'basel_design_status',
            'basel_primary_accent_color',
            'basel_top_note_bg',
            'basel_top_note_color',
            'basel_top_line_bg',
            'basel_top_line_color',
            'basel_header_bg',
            'basel_header_color',
            'basel_header_accent',
            'basel_header_menu_bg',
            'basel_header_menu_color',
            'basel_search_scheme',
            'basel_vertical_menu_bg',
            'basel_vertical_menu_bg_hover',
            'basel_menutag_sale_bg',
            'basel_menutag_new_bg',
            'basel_bc_color',
            'basel_bc_bg_color',
            'basel_bc_bg_img',
            'basel_bc_bg_img_pos',
            'basel_bc_bg_img_repeat',
            'basel_bc_bg_img_size',
            'basel_bc_bg_img_att',
            'basel_body_bg_color',
            'basel_body_bg_img',
            'basel_body_bg_img_pos',
            'basel_body_bg_img_repeat',
            'basel_body_bg_img_size',
            'basel_body_bg_img_att',
            'basel_default_btn_bg',
            'basel_default_btn_color',
            'basel_default_btn_bg_hover',
            'basel_default_btn_color_hover',
            'basel_contrast_btn_bg',
            'basel_salebadge_bg',
            'basel_salebadge_color',
            'basel_newbadge_bg',
            'basel_newbadge_color',
            'basel_price_color',
            'basel_footer_bg',
            'basel_footer_color',
            'basel_footer_h5_sep',
            'basel_sticky_columns',
            'basel_sticky_columns_offset',
            'basel_main_layout',
            'basel_content_width',
            'basel_cart_icon',
            'basel_typo_status',
            'basel_fonts',
            'body_font_fam',
            'body_font_italic_status',
            'body_font_bold_weight',
            'contrast_font_fam',
            'body_font_size_16',
            'body_font_size_15',
            'body_font_size_14',
            'body_font_size_13',
            'body_font_size_12',
            'headings_fam',
            'headings_weight',
            'headings_size_sm',
            'headings_size_lg',
            'h1_inline_fam',
            'h1_inline_size',
            'h1_inline_weight',
            'h1_inline_trans',
            'h1_inline_ls',
            'h1_breadcrumb_fam',
            'h1_breadcrumb_size',
            'h1_breadcrumb_weight',
            'h1_breadcrumb_trans',
            'h1_breadcrumb_ls',
            'widget_sm_fam',
            'widget_sm_size',
            'widget_sm_weight',
            'widget_sm_trans',
            'widget_sm_ls',
            'widget_lg_fam',
            'widget_lg_size',
            'widget_lg_weight',
            'widget_lg_trans',
            'widget_lg_ls',
            'menu_font_fam',
            'menu_font_size',
            'menu_font_weight',
            'menu_font_trans',
            'menu_font_ls',
            'basel_sticky_header',
            'basel_home_overlay_header',
            'basel_widget_title_style',
            'quickview_popup_image_width',
            'quickview_popup_image_height',
            'subcat_image_width',
            'subcat_image_height',
            'basel_custom_css_status',
            'basel_custom_css',
            'basel_custom_js_status',
            'basel_custom_js',
            'basel_thumb_swap',
            'basel_price_update',
            'basel_sharing_style',
            // Contact page
            'basel_map_style',
            'basel_map_lon',
            'basel_map_lat',
            'basel_map_api',
            'basel_yandex_map'
        );

        // Contacts
        $data['basel_contacts'] = array(
            'main_phone',
            'main_email',
            'main_address',
            'main_working_hours',
            'secondary_phone',
            'secondary_email',
            'secondary_address',
            'secondary_working_hours',
            'basel_max',
            'basel_whatsapp',
            'basel_telegram',
            'basel_vkontakte',
            'basel_instagram',
            'basel_tiktok',
            'basel_avito',
        );

        $data['basel_resolutions'] = array(
            'xs',
            'md',
            'lg',
            'xl',
        );

        foreach ($data['basel_contacts'] as $contact) {
            $codes['basel'][] = $contact;
            foreach ($data['basel_resolutions'] as $resolution) {
                $codes['basel'][] = $contact . '_header_' . $resolution;
                $codes['basel'][] = $contact . '_contact_page_' . $resolution;
            }
        }

        foreach ($codes as $code => $variables) {
            foreach ($variables as $variable) {
                // Main contact fields are loaded later from main config
                if (in_array($variable, ['main_phone', 'main_address', 'main_email', 'main_working_hours'])) {
                    continue;
                }

                if (isset($this->request->post[$variable])) {
                    $data[$variable] = $this->request->post[$variable];
                } else {
                    $data[$variable] = $this->getConfig($variable);
                }
            }
        }

        // Footer links
        $basel_footer_columns = $data['basel_footer_columns'];
        $data['basel_footer_columns'] = array();
        if (!empty($basel_footer_columns)) {
            foreach ($basel_footer_columns as $basel_footer_column) {
                $links = array();
                $i = 0;
                if (isset($basel_footer_column['links'])) {
                    foreach ($basel_footer_column['links'] as $link) {
                        $links[$i] = $link;
                        $i++;
                    }
                    usort($links, function ($a, $b) {
                        return $a['sort'] - $b['sort'];
                    });
                }
                $data['basel_footer_columns'][] = array(
                    'title' => $basel_footer_column['title'],
                    'sort' => $basel_footer_column['sort'],
                    'links' => $links,
                );
            }
            usort($data['basel_footer_columns'], function ($a, $b) {
                return $a['sort'] - $b['sort'];
            });
        }

        // Header static links
        if (!empty($data['basel_links'])) {
            usort($data['basel_links'], function ($a, $b) {
                return $a['sort'] - $b['sort'];
            });
        }

        // Theme content start
        // $data['heading_title'] = $this->language->get('heading_title');
        // $data['button_save'] = $this->language->get('button_save');
        // $data['text_disabled'] = $this->language->get('text_disabled');
        // $data['text_enabled'] = $this->language->get('text_enabled');

        $data += $this->load->language('basel/basel');

        $data['action'] = $this->url->link('extension/basel/basel', $token_prefix . '=' . $this->session->data[$token_prefix], true);


        // Stores
        $data['stores'] = array();

        $data['stores'][] = array(
            'name' => 'Default',
            'href' => '',
            'store_id' => 0
        );

        $this->load->model('setting/store');
        $stores = $this->model_setting_store->getStores();

        foreach ($stores as $store) {
            $data['stores'][] = $store;
        }

        // One Click Installer
        $data['demo_import_url'] = $this->url->link('extension/basel/basel', $token_prefix . '=' . $this->session->data[$token_prefix] . '&import_demo=', true);

        $data['demos'] = array();
        $demos = glob(DIR_APPLICATION . 'model/extension/basel/demo_stores/*');
        if ($demos) {
            natsort($demos);
            foreach ($demos as $demo) {
                $data['demos'][] = array(
                    'demo_id' => basename($demo),
                    'name' => file_get_contents(DIR_APPLICATION . 'model/extension/basel/demo_stores/' . basename($demo) . '/name.txt')
                );
            }
        }

        // Fallback values for the first time
        if (is_null($this->getConfig('theme_default_directory'))) $data['theme_default_directory'] = 'default';
        if (is_null($this->getConfig('basel_header'))) $data['basel_header'] = 'header1';
        if (is_null($this->getConfig('top_line_style'))) $data['top_line_style'] = '1';
        if (is_null($this->getConfig('top_line_height'))) $data['top_line_height'] = '41';
        if (is_null($this->getConfig('main_header_height'))) $data['main_header_height'] = '104';
        if (is_null($this->getConfig('main_header_height_mobile'))) $data['main_header_height_mobile'] = '70';
        if (is_null($this->getConfig('main_header_height_sticky'))) $data['main_header_height_sticky'] = '70';
        if (is_null($this->getConfig('menu_height_normal'))) $data['menu_height_normal'] = '50';
        if (is_null($this->getConfig('menu_height_sticky'))) $data['menu_height_sticky'] = '47';
        if (is_null($this->getConfig('logo_maxwidth'))) $data['logo_maxwidth'] = '250';
        if (is_null($this->getConfig('basel_sticky_header'))) $data['basel_sticky_header'] = '1';
        if (is_null($this->getConfig('basel_home_overlay_header'))) $data['basel_home_overlay_header'] = '0';
        if (is_null($this->getConfig('header_login'))) $data['header_login'] = '1';
        if (is_null($this->getConfig('header_search'))) $data['header_search'] = '1';
        if (is_null($this->getConfig('header_phone'))) $data['header_phone'] = '1';
        if (is_null($this->getConfig('primary_menu'))) $data['primary_menu'] = 'oc';
        if (is_null($this->getConfig('use_custom_links'))) $data['use_custom_links'] = '0';
        if (is_null($this->getConfig('basel_back_btn'))) $data['basel_back_btn'] = '0';
        if (is_null($this->getConfig('basel_hover_zoom'))) $data['basel_hover_zoom'] = '1';
        if (is_null($this->getConfig('meta_description_status'))) $data['meta_description_status'] = '1';
        if (is_null($this->getConfig('product_page_countdown'))) $data['product_page_countdown'] = '0';
        if (is_null($this->getConfig('basel_share_btn'))) $data['basel_share_btn'] = '1';
        if (is_null($this->getConfig('ex_tax_status'))) $data['ex_tax_status'] = '0';
        if (is_null($this->getConfig('product_question_status'))) $data['product_question_status'] = '0';
        if (is_null($this->getConfig('questions_new_status'))) $data['questions_new_status'] = '0';
        if (is_null($this->getConfig('basel_rel_prod_grid'))) $data['basel_rel_prod_grid'] = '4';
        if (is_null($this->getConfig('category_thumb_status'))) $data['category_thumb_status'] = '0';
        if (is_null($this->getConfig('category_subs_status'))) $data['category_subs_status'] = '1';
        if (is_null($this->getConfig('basel_subs_grid'))) $data['basel_subs_grid'] = '5';
        if (is_null($this->getConfig('basel_prod_grid'))) $data['basel_prod_grid'] = '3';
        if (is_null($this->getConfig('catalog_mode'))) $data['catalog_mode'] = '0';
        if (is_null($this->getConfig('basel_cut_names'))) $data['basel_cut_names'] = '1';
        if (is_null($this->getConfig('items_mobile_fw'))) $data['items_mobile_fw'] = '1';
        if (is_null($this->getConfig('quickview_status'))) $data['quickview_status'] = '1';
        if (is_null($this->getConfig('salebadge_status'))) $data['salebadge_status'] = '1';
        if (is_null($this->getConfig('stock_badge_status'))) $data['stock_badge_status'] = '1';
        if (is_null($this->getConfig('countdown_status'))) $data['countdown_status'] = '1';
        if (is_null($this->getConfig('wishlist_status'))) $data['wishlist_status'] = '1';
        if (is_null($this->getConfig('compare_status'))) $data['compare_status'] = '1';
        if (is_null($this->getConfig('overwrite_footer_links'))) $data['overwrite_footer_links'] = '0';
        if (is_null($this->getConfig('basel_top_promo_status'))) $data['basel_top_promo_status'] = '0';
        if (is_null($this->getConfig('basel_top_promo_close'))) $data['basel_top_promo_close'] = '0';
        if (is_null($this->getConfig('basel_cookie_bar_status'))) $data['basel_cookie_bar_status'] = '0';
        if (is_null($this->getConfig('basel_popup_note_status'))) $data['basel_popup_note_status'] = '0';
        if (is_null($this->getConfig('basel_popup_note_once'))) $data['basel_popup_note_once'] = '0';
        if (is_null($this->getConfig('basel_popup_note_home'))) $data['basel_popup_note_home'] = '0';
        if (is_null($this->getConfig('basel_popup_note_m'))) $data['basel_popup_note_m'] = '767';
        if (is_null($this->getConfig('basel_cart_icon'))) $data['basel_cart_icon'] = 'global-cart-basket';
        if (is_null($this->getConfig('basel_main_layout'))) $data['basel_main_layout'] = '0';
        if (is_null($this->getConfig('product_tabs_style'))) $data['product_tabs_style'] = 'nav-tabs-lg text-center';
        if (is_null($this->getConfig('basel_sticky_columns'))) $data['basel_sticky_columns'] = '1';
        if (is_null($this->getConfig('basel_design_status'))) $data['basel_design_status'] = '0';
        if (is_null($this->getConfig('basel_typo_status'))) $data['basel_typo_status'] = '0';
        if (is_null($this->getConfig('basel_custom_css_status'))) $data['basel_custom_css_status'] = '0';
        if (is_null($this->getConfig('basel_custom_js_status'))) $data['basel_custom_js_status'] = '0';
        if (is_null($this->getConfig('theme_default_product_limit'))) $data['theme_default_product_limit'] = '12';
        if (is_null($this->getConfig('body_font_italic_status'))) $data['body_font_italic_status'] = '1';
        if (is_null($this->getConfig('quickview_popup_image_width'))) $data['quickview_popup_image_width'] = '465';
        if (is_null($this->getConfig('quickview_popup_image_height'))) $data['quickview_popup_image_height'] = '590';
        if (is_null($this->getConfig('subcat_image_width'))) $data['subcat_image_width'] = '200';
        if (is_null($this->getConfig('subcat_image_height'))) $data['subcat_image_height'] = '264';
        if (is_null($this->getConfig('basel_thumb_swap'))) $data['basel_thumb_swap'] = '1';
        if (is_null($this->getConfig('basel_price_update'))) $data['basel_price_update'] = '1';
        if (is_null($this->getConfig('basel_sharing_style'))) $data['basel_sharing_style'] = 'small';

        // Contact page
        if (is_null($this->getConfig('basel_map_style'))) $data['basel_map_style'] = '0';
        if (is_null($this->getConfig('basel_map_lon'))) $data['basel_map_lon'] = '';
        if (is_null($this->getConfig('basel_map_lat'))) $data['basel_map_lat'] = '';
        if (is_null($this->getConfig('basel_map_api'))) $data['basel_map_api'] = '';
        if (is_null($this->getConfig('basel_yandex_map'))) $data['basel_yandex_map'] = '';

        if (empty($data['basel_theme_version'])) {
            $data['theme_default_image_category_width'] = '335';
            $data['theme_default_image_category_height'] = '425';
            $data['theme_default_image_thumb_width'] = '406';
            $data['theme_default_image_thumb_height'] = '516';
            $data['theme_default_image_popup_width'] = '910';
            $data['theme_default_image_popup_height'] = '1155';
            $data['theme_default_image_product_width'] = '262';
            $data['theme_default_image_product_height'] = '334';
            $data['theme_default_image_additional_width'] = '130';
            $data['theme_default_image_additional_height'] = '165';
            $data['theme_default_image_related_width'] = '262';
            $data['theme_default_image_related_height'] = '334';
            $data['theme_default_image_compare_width'] = '130';
            $data['theme_default_image_compare_height'] = '165';
            $data['theme_default_image_wishlist_width'] = '55';
            $data['theme_default_image_wishlist_height'] = '70';
            $data['theme_default_image_cart_width'] = '100';
            $data['theme_default_image_cart_height'] = '127';
            $data['theme_default_image_location_width'] = '268';
            $data['theme_default_image_location_height'] = '50';
            $data['quickview_popup_image_width'] = '465';
            $data['quickview_popup_image_height'] = '590';
            $data['subcat_image_width'] = '200';
            $data['subcat_image_height'] = '264';
        }

        // Contacts - always load from main config, not from basel settings
        $front_lang_id = $this->config->get('config_language_id');
        $this->load->model('extension/basel/basel');
        $data['main_phone'] = $this->model_extension_basel_basel->getConfigWithLangFallback('config_telephone');
        $data['main_address'] = $this->model_extension_basel_basel->getConfigWithLangFallback('config_address');
        $data['main_email'] = $this->model_extension_basel_basel->getConfigWithLangFallback('config_email');
        $data['main_working_hours'] = $this->model_extension_basel_basel->getConfigWithLangFallback('config_open');

        // if (is_null($this->getConfig('secondary_phone'))) $data['secondary_phone'] = '';
        // if (is_null($this->getConfig('secondary_address'))) $data['secondary_address'] = '';
        // if (is_null($this->getConfig('secondary_email'))) $data['secondary_email'] = '';
        // if (is_null($this->getConfig('secondary_working_hours'))) $data['secondary_working_hours'] = '';

        // if (is_null($this->getConfig('basel_max'))) $data['basel_max'] = '';
        // if (is_null($this->getConfig('basel_whatsapp'))) $data['basel_whatsapp'] = '';
        // if (is_null($this->getConfig('basel_telegram'))) $data['basel_telegram'] = '';
        // if (is_null($this->getConfig('basel_vkontakte'))) $data['basel_vkontakte'] = '';
        // if (is_null($this->getConfig('basel_instagram'))) $data['basel_instagram'] = '';
        // if (is_null($this->getConfig('basel_tiktok'))) $data['basel_tiktok'] = '';
        // if (is_null($this->getConfig('basel_avito'))) $data['basel_avito'] = '';

        foreach ($data['basel_contacts'] as $contact) {
            foreach ($data['basel_resolutions'] as $resolution) {
                if (is_null($this->getConfig($contact . '_' . $resolution))) $data[$contact . '_' . $resolution] = '0';
            }
            if (in_array($contact, ['main_phone', 'main_address', 'main_email', 'main_working_hours'])) {
                continue;
            }
            if (is_null($this->getConfig($contact))) $data[$contact] = '';
        }

        // Render page
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/basel/basel', $data));

        unset($this->session->data['permission_error']);
    }

    private function validate()
    {
        if (!$this->user->hasPermission('modify', 'extension/basel/basel')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        return !$this->error;
    }

    private function getConfig($key)
    {
        $this->load->model('extension/basel/basel');
        $value = $this->model_extension_basel_basel->getSettingValue($key, $this->store_id);
        return $value;
    }
}
