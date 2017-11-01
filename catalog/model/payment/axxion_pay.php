<?php 
class ModelPaymentAxxionPay extends Model {
  	public function getMethod($address, $total) {
		$this->load->language('payment/axxion_pay');
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$this->config->get('axxion_pay_geo_zone_id') . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");
		
		if (!$this->config->get('axxion_pay_geo_zone_id')) {
			$status = true;
		} elseif ($query->num_rows) {
			$status = true;
		} else {
			$status = false;
		}	

		$currencies = array(
			'CLP',
			'ARS',
			'EUR',
		);
		
		if(version_compare(VERSION, '2.2.0.0', '>=')){
			if (!in_array(strtoupper($this->config->get('config_currency')), $currencies)) {
				$status = false;
			}
		} else {
			if (!in_array(strtoupper($this->currency->getCode()), $currencies)) {
				$status = false;
			}
		}
					
		$method_data = array();
	
		if ($status) {  
      		$method_data = array( 
        		'code'       => 'axxion_pay',
      			'terms'      => '',
        		'title'      => $this->language->get('text_title'),
				'sort_order' => $this->config->get('axxion_pay_sort_order')
      		);
    	}
   
    	return $method_data;
  	}
}
?>
