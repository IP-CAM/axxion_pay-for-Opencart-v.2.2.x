
<div class="buttons">
  <div class="pull-right">
    <input type="button" value="<?php echo $data['button_confirm']; ?>" id="button-confirm" class="btn btn-primary" />
  </div>
</div>
<script type="text/javascript"><!--
$('#button-confirm').on('click', function() {
	$.ajax({
		type: 'get',
		url: "<?php echo $data['action']; ?>",
		beforeSend: function() {
			$('#button-confirm').button('loading');
		},
		complete: function() {
			$('#button-confirm').button('reset');
		},
		success: function(res) {
			if (res.status == 'success') {
				console.log(res);
				var URL = res.payment_url;
				window.location.href = URL;
			}
			
		}
	});
});

//--></script>