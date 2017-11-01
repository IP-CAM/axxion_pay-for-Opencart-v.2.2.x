<?php


function curlSend($url, $data){
	$curl = curl_init();
	curl_setopt_array($curl, [
		CURLOPT_RETURNTRANSFER => 1,
		CURLOPT_URL => $url,
		CURLOPT_HTTPHEADER => ['Content-Type: application/json','Content-Length: ' . strlen($data)],
		CURLOPT_POST => 1,
		CURLOPT_POSTFIELDS => $data
	]);
	$response = curl_exec($curl);
	header("Access-Control-Allow-Origin: *");
	if(curl_errno($curl)){
		$response =json_encode([
			'status' => 'error',
			'error' => curl_error($curl),
			'code' => curl_errno($curl),
		]);
    	
	}
	curl_close($curl);
	return $response;
}


?> 