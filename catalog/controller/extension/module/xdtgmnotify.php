<?php
class ControllerExtensionModuleXdtgmnotify extends Controller {
    public function order(&$route, &$args) {
        if (isset($args[0])) {
            $order_id = $args[0];
        } else {
            $order_id = 0;
        }
        if (isset($args[1])) {
            $order_status_id = $args[1];
        } else {
            $order_status_id = 0;
        }
        if (isset($args[2])) {
            $comment = $args[2];
        } else {
            $comment = '';
        }
        $this->load->model('checkout/order');
	    $logger = new Log('tgm_log.log');

        $order_info = $this->model_checkout_order->getOrder($order_id);
		// var_dump($order_info);
		// $logger->write("ORDER: ".print_r($order_info,true));
		$module_xdtgmnotify_status = $this->config->get('module_xdtgmnotify_status');
        if ($order_info && $module_xdtgmnotify_status) {
			$logger->write("ORDER ID: ".print_r($order_id,true) . " SENDING TGM MSG");
			$this->load->model('extension/module/xdtgmnotify');
            $this->model_extension_module_xdtgmnotify->sendTgmMsg($order_info);
        } else {
			$logger->write("ORDER ID: ".print_r($order_id,true) . " ERROR");
		}
    }
}