<?php
class ModelExtensionShippingpickup1 extends Model
{
    function getQuote($address)
    {
        $this->load->language('extension/shipping/pickup1');

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$this->config->get('pickup1_geo_zone_id') . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");

        if (!$this->config->get('pickup1_geo_zone_id')) {
            $status = true;
        } elseif ($query->num_rows) {
            $status = true;
        } else {
            $status = false;
        }

        $method_data = array();

        $data['pickup_module_description'] = ($this->config->get('pickup1_module_title')) ? $this->config->get('pickup1_module_title') : $this->language->get('heading_title');
        $data['pickup_address'] = ($this->config->get('pickup1_address')) ? $this->config->get('pickup1_address') : '';

        if ($status) {
            $quote_data = array();

            $quote_data['pickup1'] = array(
                'code'         => 'pickup1.pickup1',
                'title'        => $data['pickup_module_description'],
                'cost'         => 0.00,
                'tax_class_id' => 0,
                'text'         => $this->currency->format(0.00, $this->session->data['currency']),
                'address'      => $data['pickup_address']
            );

            $method_data = array(
                'code'       => 'pickup1',
                'title'      => $this->language->get('text_title'),
                'quote'      => $quote_data,
                'sort_order' => $this->config->get('pickup1_sort_order'),
                'error'      => false
            );
        }

        return $method_data;
    }
}
