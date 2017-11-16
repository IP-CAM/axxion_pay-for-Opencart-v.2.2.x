<?php

require_once('axxion_crypt.php');
include_once('axxion_lib.php');

class ControllerPaymentAxxionPay extends Controller {
	const version = "0.0.1";

	private $error;
	public $sucess = true;
	private $order_info;
	private $message;

	public function index(){
		$this->load->language('payment/axxion_pay');
		$data['button_confirm'] = $this->language->get('button_confirm');
		$data['button_back'] = $this->language->get('button_back');
		$data['customer_email'] = $this->customer->getEmail();
		$data['action'] =  $this->url->link('payment/axxion_pay/generateOrder');
		$data['terms'] = '';

		$data['server'] = $_SERVER;
		$data['user_logged'] = $this->customer->isLogged();


		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/axxion_pay.tpl')){
			$this->template = $this->config->get('config_template') . '/template/payment/axxion_pay.tpl';
		} else {
			$this->template = 'default/template/payment/axxion_pay.tpl';
		}

		return $this->load->view($this->template, $data);
	}

	public function generateOrder(){
		$this->load->model('checkout/order');
		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
		if ($order_info) {
				$data['currency'] = $order_info['currency_code'];
				$data['orderamount'] = $this->currency->format($order_info['total'], $data['currency'] , false, false);
				$data['callbackurl'] = $this->url->link('payment/axxion_pay/callback');
				$data['success_url'] = $this->url->link('checkout/success');
				$data['error_url'] = $this->url->link('checkout/checkout');
				$data['order_id'] = $_SERVER['HTTP_HOST'].'_'.$this->session->data['order_id'];
				$data['cart_email'] = trim($this->config->get('axxion_pay_cryptomkt_email'));
			}
		$data['api'] = [
			'currency' =>  $data['currency'],
			'amount' =>  $data['orderamount'],
			'callback_url' => $data['callbackurl'],
			'order_id' => $data['order_id'],
			'cart_email' => $data['cart_email'],
			'referer' => $_SERVER['HTTP_HOST'],
			'success_url' => $data['success_url'],
			'error_url' => $data['error_url'],
			'gateway' => $this->config->get('axxion_pay_gateway'),
		];

		$data['api_send'] = cryptoJsAesEncrypt($data['api']);
		$response = curlSend('https://cryptopago.itaxxion.cl/api/opencart/generateQR', $data['api_send']);

		$responseData = json_decode($response);
		header('Content-Type: application/json');
		if ($responseData->status == 'success') {
			$order_info['payment_custom_field']['token'] = $responseData->data->token;
			$this->session->data['token'] = $responseData->data->token;
			$this->addTokenToOrder($this->session->data['order_id'], $responseData->data->token);
			//FEEDBACK: No not add to order until gets paid
			//$this->model_checkout_order->addOrderHistory($this->session->data['order_id'], $this->config->get('axxion_pay_entry_order_waiting'));
			//TODO: Handle axxion gateway or cryptomkt gateway
			echo json_encode([
				'status' => 'success',
				'payment_url' => $responseData->data->payment_url,
			]);
		}
		else echo $response;

	}

	public function callback() {
		if (isset($this->request->post['external_id'])) {
			$order_id = trim(explode($_SERVER['host'].'_', $this->request->post['external_id'],2)[1]);
		} else {
			die('Illegal Access');
		}
		$obs = "";
		$notify = false;
		if (isset($this->request->post['obs'])) {
			$obs = $this->request->post['obs'];
		}
		
		$this->load->model('checkout/order');
		$order_info = $this->model_checkout_order->getOrder($order_id);

		if ($order_info) {
			if (isset($this->request->post['token']) && $this->request->post['token'] == $order_info['payment_custom_field']['token']){
				switch ((integer)$this->request->post['status']) {
					case -4:
						$order_status = $this->config->get('axxion_pay_order_multiple_pay');
						$notify = (boolean)$this->config->get('axxion_pay_notify_order_multiple_pay');
						break;
					case -3: 
						$order_status = $this->config->get('axxion_pay_order_not_matching_pay');
						$notify = (boolean)$this->config->get('axxion_pay_notify_order_not_matching_pay');
						break;
					case -2: 
						$order_status = $this->config->get('axxion_pay_order_multiple_pay');
						$notify = (boolean)$this->config->get('axxion_pay_notify_order_multiple_pay');
						break;
					case -1: 
						$order_status = $this->config->get('axxion_pay_entry_order_expired');
						$notify = (boolean)$this->config->get('axxion_pay_notify_order_expired');
						break;
					case 0:
						$order_status = $this->config->get('axxion_pay_entry_order_waiting');
						$notify = (boolean)$this->config->get('axxion_pay_notify_order_waiting');
						break;
					case 1:
						$order_status = $this->config->get('axxion_pay_entry_order_waiting_block');
						$notify = (boolean)$this->config->get('axxion_pay_notify_order_waiting_block');
						break;
					case 2:
						$order_status = $this->config->get('axxion_pay_entry_order_processing');
						$notify = (boolean)$this->config->get('axxion_pay_notify_order_processing');
						break;
					case 3:
						$order_status = $this->config->get('axxion_pay_entry_order_success');
						$notify = (boolean)$this->config->get('axxion_pay_notify_order_success');
						break;
					default:
						# code...
						break;
				}
				$notify = $notify == null ? false : $notify;
				if (isset($this->request->post['obs'])) {
					$obs = $this->request->post['obs'];
				}
				$this->model_checkout_order->addOrderHistory($order_info['order_id'], $order_status, $obs, $notify);
			} else {
				die('Illegal Access');
			}
		}
	}

	public function setCookie() {
		if (isset($this->request->post['token'])){
			$this->session->data['payment_token'] = $this->request->post['token'];
		}
	}

	public function success() {

	}

	public function error() {

	}

	private function addTokenToOrder($order_id, $token){
		$this->load->model('checkout/order');
		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
		$payment_custom_field = $order_info['payment_custom_field'];
		$payment_custom_field['token'] = $token;
		$this->db->query("UPDATE `" . DB_PREFIX . "order` SET payment_custom_field = '" . $this->db->escape(json_encode($payment_custom_field)) .  "', date_modified = NOW() WHERE order_id = '" . (int)$order_id . "'");

	}
}