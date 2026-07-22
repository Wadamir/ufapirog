<?php
class ControllerExtensionShippingPickup1 extends Controller
{
    private $error = array();

    public function index()
    {
        $this->load->language('extension/shipping/pickup1');

        if ($this->config->get('pickup1_module_title')) {
            $this->document->setTitle($this->config->get('pickup1_module_title'));
        } else {
            $this->document->setTitle($this->language->get('heading_title'));
        }
        // $this->document->setTitle($this->language->get('heading_title'));



        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('pickup1', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=shipping', true));
        }

        if ($this->config->get('pickup1_module_title')) {
            $data['heading_title'] = $this->config->get('pickup1_module_title');
        } else {
            $data['heading_title'] = $this->language->get('heading_title');
        }
        // $data['heading_title'] = $this->language->get('heading_title');

        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_all_zones'] = $this->language->get('text_all_zones');
        $data['text_none'] = $this->language->get('text_none');

        $data['entry_module_title'] = $this->language->get('entry_module_title');
        $data['entry_pickup_address'] = $this->language->get('entry_pickup_address');
        $data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
        $data['entry_status'] = $this->language->get('entry_status');
        $data['entry_sort_order'] = $this->language->get('entry_sort_order');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_extension'),
            'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=shipping', true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $data['heading_title'],
            'href' => $this->url->link('extension/shipping/pickup1', 'token=' . $this->session->data['token'], true)
        );

        $data['action'] = $this->url->link('extension/shipping/pickup1', 'token=' . $this->session->data['token'], true);

        $data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=shipping', true);

        if (isset($this->request->post['pickup1_module_title'])) {
            $data['pickup1_module_title'] = $this->request->post['pickup1_module_title'];
        } else if ($this->config->get('pickup1_module_title')) {
            $data['pickup1_module_title'] = $this->config->get('pickup1_module_title');
        } else {
            $data['pickup1_module_title'] = $this->language->get('heading_title');
        }

        if (isset($this->request->post['pickup1_address'])) {
            $data['pickup1_address'] = $this->request->post['pickup1_address'];
        } else if ($this->config->get('pickup1_address')) {
            $data['pickup1_address'] = $this->config->get('pickup1_address');
        } else {
            $data['pickup1_address'] = '';
        }

        if (isset($this->request->post['pickup1_geo_zone_id'])) {
            $data['pickup1_geo_zone_id'] = $this->request->post['pickup1_geo_zone_id'];
        } else {
            $data['pickup1_geo_zone_id'] = $this->config->get('pickup1_geo_zone_id');
        }

        $this->load->model('localisation/geo_zone');

        $data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

        if (isset($this->request->post['pickup1_status'])) {
            $data['pickup1_status'] = $this->request->post['pickup1_status'];
        } else {
            $data['pickup1_status'] = $this->config->get('pickup1_status');
        }

        if (isset($this->request->post['pickup1_sort_order'])) {
            $data['pickup1_sort_order'] = $this->request->post['pickup1_sort_order'];
        } else {
            $data['pickup1_sort_order'] = $this->config->get('pickup1_sort_order');
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/shipping/pickup1', $data));
    }

    protected function validate()
    {
        if (!$this->user->hasPermission('modify', 'extension/shipping/pickup1')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        return !$this->error;
    }
}
