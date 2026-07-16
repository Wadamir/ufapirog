<?php
class ControllerExtensionModuleXdtgmnotify extends Controller {
    private $error = array();
    public function index() {
		$lang = $this->load->language('extension/module/xdtgmnotify');
		$data = array_merge($lang, []);
		$this->document->setTitle($this->language->get('heading_name'));
		$this->load->model('setting/setting');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('xdtgmnotify', $this->request->post);
			$this->model_setting_setting->editSetting('module_xdtgmnotify', $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}
		/*
		// Heading
		$data['heading_title'] = $this->language->get('heading_title');
		$data['heading_name'] = $this->language->get('heading_name');
		// Text
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		// Buttons
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		// Tabs
		$data['settings_main'] = $this->language->get('settings_main');
		$data['text_tab_help'] = $this->language->get('text_tab_help');
		// Entry
		$data['entry_log_status'] = $this->language->get('entry_log_status');
		$data['entry_xdtgmnotify_status'] = $this->language->get('entry_xdtgmnotify_status');
		$data['entry_bot'] = $this->language->get('entry_bot');
		$data['entry_chat'] = $this->language->get('entry_chat');
		*/
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		if (isset($this->error['bot'])) {
			$data['error_bot'] = $this->error['bot'];
		} else {
			$data['error_bot'] = '';
		}
		if (isset($this->error['chat'])) {
			$data['error_chat'] = $this->error['chat'];
		} else {
			$data['error_chat'] = '';
		}		
		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_name'),
			'href' => $this->url->link('extension/module/xdtgmnotify', 'token=' . $this->session->data['token'], true)
		);
		$data['action'] = $this->url->link('extension/module/xdtgmnotify', 'token=' . $this->session->data['token'], true);
		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();
		$languages = $this->model_localisation_language->getLanguages();
		if (isset($this->request->post['xdtgmnotify'])) {
			$data['xdtgmnotify'] = $this->request->post['xdtgmnotify'];
		} else {
			$data['xdtgmnotify'] = $this->config->get('xdtgmnotify');
		}
		$tgm_notify_log = isset($data['xdtgmnotify']['log']) ? $data['xdtgmnotify']['log'] : false;
		if (isset($this->request->post['module_xdtgmnotify_status'])) {
			$data['module_xdtgmnotify_status'] = $this->request->post['module_xdtgmnotify_status'];
		} else {
			$data['module_xdtgmnotify_status'] = $this->config->get('module_xdtgmnotify_status');
		}
        $data['tgm_log'] = '';
        $data['tgm_log_filname'] = 'tgm_log.log';
        if ($tgm_notify_log) {
            $file = DIR_LOGS . $data['tgm_log_filname'];
            if (file_exists($file)) {
                $size = filesize($file);
                if ($size >= 5242880) {
                    $suffix = [
                        'B',
                        'KB',
                        'MB',
                        'GB',
                        'TB',
                        'PB',
                        'EB',
                        'ZB',
                        'YB',
                    ];
                    $i = 0;
                    while (($size / 1024) > 1) {
                        $size = $size / 1024;
                        $i++;
                    }
                    $data['error_warning'] = sprintf($this->language->get('error_warning'), basename($file), round(substr($size, 0, strpos($size, '.') + 4), 2) . $suffix[$i]);
                } else {
                    $data['tgm_log'] = file_get_contents($file, FILE_USE_INCLUDE_PATH, null);
                }
            }
        } else {
            $this->clearLog();
        }
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');
        $this->response->setOutput($this->load->view('extension/module/xdtgmnotify', $data));
    }
    public function clearLog() {
        $json = [];
        $this->load->language('extension/module/xdtgmnotify');
        if (!$this->user->hasPermission('modify', 'extension/module/xdtgmnotify')) {
            $json['error'] = $this->language->get('error_permission');
        } else {
            $file = DIR_LOGS . 'tgm_log.log';
            $handle = fopen($file, 'w+');
            fclose($handle);
            $json['success'] = $this->language->get('text_success_log');
        }
        $this->response->setOutput(json_encode($json));
    }
    public function install() {
        //Add Events
		$this->load->model('extension/event');
		$this->model_extension_event->addEvent('xdtgmnotify','catalog/model/checkout/order/addOrderHistory/after','extension/module/xdtgmnotify/order');
	}
    public function uninstall() {
        //Remove Events
        $this->load->model('extension/event');
        $this->model_extension_event->deleteEvent('xdtgmnotify');
    }
    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/module/xdtgmnotify')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
		if ((utf8_strlen($this->request->post['xdtgmnotify']['bot']) < 40) || (utf8_strlen($this->request->post['xdtgmnotify']['bot']) > 64)) {
			$this->error['bot'] = $this->language->get('error_bot');
		}
		if ((utf8_strlen($this->request->post['xdtgmnotify']['chat']) < 4) || (utf8_strlen($this->request->post['xdtgmnotify']['chat']) > 64)) {
			$this->error['chat'] = $this->language->get('error_chat');
		}
        return !$this->error;
    }
}