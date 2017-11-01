<?php
class ControllerPaymentAxxionPay extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('payment/axxion_pay');

		$this->document->setTitle('Axxion Payment Gateway');

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('axxion_pay', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['button_save'] = $this->language->get('text_button_save');
		$data['button_cancel'] = $this->language->get('text_button_cancel');
		$data['text_all_zones'] = $this->language->get('text_all_zones');

		$data['entry_cryptomkt_email'] = $this->language->get('cryptomkt_email');
		$data['help_cryptomkt_email'] = $this->language->get('help_cryptomkt_email');
		$data['entry_min_order_value'] = $this->language->get('min_order_value');
		$data['help_min_order_value'] = $this->language->get('help_min_order_value');

		$data['entry_order_status'] = $this->language->get('entry_order_status');
		$data['help_entry_order_status'] = $this->language->get('help_entry_order_status');
		$data['entry_message_statuses'] = $this->language->get('entry_message_statuses');

		$data['entry_order_multiple_pay'] = $this->language->get('entry_order_multiple_pay');
		$data['help_entry_order_multiple_pay'] = $this->language->get('help_entry_order_multiple_pay');
		
		$data['entry_order_not_matching_pay'] = $this->language->get('entry_order_not_matching_pay');
		$data['help_entry_order_not_matching_pay'] = $this->language->get('help_entry_order_not_matching_pay');

		$data['entry_order_expired'] = $this->language->get('entry_order_expired');
		$data['help_entry_order_expired'] = $this->language->get('help_entry_order_expired');

		$data['entry_order_waiting'] = $this->language->get('entry_order_waiting');
		$data['help_entry_order_waiting'] = $this->language->get('help_entry_order_waiting');

		$data['entry_order_waiting_block'] = $this->language->get('entry_order_waiting_block');
		$data['help_entry_order_waiting_block'] = $this->language->get('help_entry_order_waiting_block');

		$data['entry_order_processing'] = $this->language->get('entry_order_processing');
		$data['help_entry_order_processing'] = $this->language->get('help_entry_order_processing');

		$data['entry_order_success'] = $this->language->get('entry_order_success');
		$data['help_entry_order_success'] = $this->language->get('help_entry_order_success');


		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['text_payment_gateway'] = $this->language->get('text_payment_gateway');
		$data['text_axxion_portal'] = $this->language->get('text_axxion_portal');
		$data['text_cryptomkt_portal'] = $this->language->get('text_cryptomkt_portal');

		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$data['entry_status'] = $this->language->get('entry_status');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_payment'),
			'href' => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('payment/bank_transfer', 'token=' . $this->session->data['token'], 'SSL')
		);

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['action'] = $this->url->link('payment/axxion_pay', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['axxion_pay_cryptomkt_email'])) {
			$data['axxion_pay_cryptomkt_email'] = $this->request->post['axxion_pay_cryptomkt_email'];
		} else {
			$data['axxion_pay_cryptomkt_email'] = $this->config->get('axxion_pay_cryptomkt_email');
		}

		if (isset($this->request->post['axxion_pay_min_order_value'])) {
			$data['axxion_pay_min_order_value'] = $this->request->post['axxion_pay_min_order_value'];
		} else {
			$data['axxion_pay_min_order_value'] = $this->config->get('axxion_pay_min_order_value');
		}

		if (isset($this->request->post['axxion_pay_status'])) {
			$data['axxion_pay_status'] = $this->request->post['axxion_pay_status'];
		} else {
			$data['axxion_pay_status'] = $this->config->get('axxion_pay_status');
		}

		if (isset($this->request->post['axxion_pay_order_status_id'])) {
			$data['axxion_pay_order_status_id'] = $this->request->post['axxion_pay_order_status_id'];
		} else {
			$data['axxion_pay_order_status_id'] = $this->config->get('axxion_pay_order_status_id');
		}

		if (isset($this->request->post['axxion_pay_order_multiple_pay'])) {
			$data['axxion_pay_order_multiple_pay'] = $this->request->post['axxion_pay_order_multiple_pay'];
		} else {
			$data['axxion_pay_order_multiple_pay'] = $this->config->get('axxion_pay_order_multiple_pay');
		}

		if (isset($this->request->post['axxion_pay_order_not_matching_pay'])) {
			$data['axxion_pay_order_not_matching_pay'] = $this->request->post['axxion_pay_order_not_matching_pay'];
		} else {
			$data['axxion_pay_order_not_matching_pay'] = $this->config->get('axxion_pay_order_not_matching_pay');
		}

		if (isset($this->request->post['axxion_pay_entry_order_expired'])) {
			$data['axxion_pay_entry_order_expired'] = $this->request->post['axxion_pay_entry_order_expired'];
		} else {
			$data['axxion_pay_entry_order_expired'] = $this->config->get('axxion_pay_entry_order_expired');
		}

		if (isset($this->request->post['axxion_pay_entry_order_waiting'])) {
			$data['axxion_pay_entry_order_waiting'] = $this->request->post['axxion_pay_entry_order_waiting'];
		} else {
			$data['axxion_pay_entry_order_waiting'] = $this->config->get('axxion_pay_entry_order_waiting');
		}

		if (isset($this->request->post['axxion_pay_entry_order_waiting_block'])) {
			$data['axxion_pay_entry_order_waiting_block'] = $this->request->post['axxion_pay_entry_order_waiting_block'];
		} else {
			$data['axxion_pay_entry_order_waiting_block'] = $this->config->get('axxion_pay_entry_order_waiting_block');
		}

		if (isset($this->request->post['axxion_pay_entry_order_processing'])) {
			$data['axxion_pay_entry_order_processing'] = $this->request->post['axxion_pay_entry_order_processing'];
		} else {
			$data['axxion_pay_entry_order_processing'] = $this->config->get('axxion_pay_entry_order_processing');
		}

		if (isset($this->request->post['axxion_pay_entry_order_success'])) {
			$data['axxion_pay_entry_order_success'] = $this->request->post['axxion_pay_entry_order_success'];
		} else {
			$data['axxion_pay_entry_order_success'] = $this->config->get('axxion_pay_entry_order_success');
		}

		$this->load->model('localisation/order_status');
		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		if (isset($this->request->post['axxion_pay_geo_zone_id'])) {
			$data['axxion_pay_geo_zone_id'] = $this->request->post['axxion_pay_geo_zone_id'];
		} else {
			$data['axxion_pay_geo_zone_id'] = $this->config->get('axxion_pay_geo_zone_id');
		}

		$this->load->model('localisation/geo_zone');
		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

		if (isset($this->request->post['axxion_pay_sort_order'])) {
			$data['axxion_pay_sort_order'] = $this->request->post['axxion_pay_sort_order'];
		} else {
			$data['axxion_pay_sort_order'] = $this->config->get('axxion_pay_sort_order');
		}

		if (isset($this->request->post['axxion_pay_gateway'])) {
			$data['axxion_pay_gateway'] = $this->request->post['axxion_pay_gateway'];
		} else {
			$data['axxion_pay_gateway'] = $this->config->get('axxion_pay_gateway');
		}

		$this->template = 'payment/axxion_pay.tpl';

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('payment/axxion_pay.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'payment/axxion_pay')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}