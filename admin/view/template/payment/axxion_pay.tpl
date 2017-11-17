<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="axxion_pay_cryptomkt_email"><span data-toggle="tooltip" title="<?php echo $help_cryptomkt_email; ?>"><?php echo $entry_cryptomkt_email; ?></span></label>
            <div class="col-sm-10">
              <input type="text" name="axxion_pay_cryptomkt_email" value="<?php echo $axxion_pay_cryptomkt_email; ?>" placeholder="<?php echo $axxion_pay_cryptomkt_email; ?>" id="input-total" class="form-control" size="10" required="" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="axxion_pay_min_order_value"><span data-toggle="tooltip" title="<?php echo $help_min_order_value; ?>"><?php echo $entry_min_order_value; ?></span></label>
            <div class="col-sm-10">
              <input type="text" name="axxion_pay_min_order_value" value="<?php echo $axxion_pay_min_order_value; ?>" placeholder="<?php echo $axxion_pay_min_order_value; ?>" id="" class="form-control" size="10" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label"><?php echo $entry_message_statuses; ?></label>
          </div>
          <div class="form-group">
              <label class="col-sm-2 control-label" for="axxion_pay_order_status_id"><span data-toggle="tooltip" title="<?php echo $help_entry_order_status; ?>"><?php echo $entry_order_status; ?></span></label>
              <div class="col-sm-10">
                <select name="axxion_pay_order_status_id" id="input-order-status" class="form-control">
                  <?php foreach ($order_statuses as $order_status) { ?>
                  <?php if ($order_status['order_status_id'] == $axxion_pay_order_status_id) { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name'];   ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 col-xs-12 control-label" for="entry_order_multiple_pay"><span data-toggle="tooltip" title='<?php echo $help_entry_order_multiple_pay; ?> '><?php echo $entry_order_multiple_pay; ?></span></label>
            <div class="col-sm-6 col-xs-12">
              <select class="form-control" name="axxion_pay_order_multiple_pay" id="order_multiple_pay">
               <?php foreach ($order_statuses as $order_status) : ?>
                <?php if ($order_status['order_status_id'] == $axxion_pay_order_multiple_pay) : ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php else : ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php endif; ?>
              <?php endforeach; ?>
              </select>
            </div>
            <label class="col-sm-2 col-xs-6 control-label" for="axxion_pay_notify_order_multiple_pay"><span data-toggle="tooltip" title="<?php echo $help_text_notify_me; ?>"><?php echo $text_notify_me; ?></span></label>
            <div class="col-sm-2 col-xs-6">
              <label class="radio-inline">
                <input type="radio" name="axxion_pay_notify_order_multiple_pay" class="" value="1" <?php if($axxion_pay_notify_order_multiple_pay == '1') echo 'checked'; ?> ><?php echo $text_yes; ?>
              </label>
              <label class="radio-inline">
                <input type="radio" name="axxion_pay_notify_order_multiple_pay" class="" value="0" <?php if($axxion_pay_notify_order_multiple_pay != '1') echo 'checked'; ?> ><?php echo $text_no; ?>
              </label>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label col-xs-12" for="entry_order_not_matching_pay"><span data-toggle="tooltip" title='<?php echo $help_entry_order_not_matching_pay; ?> '><?php echo $entry_order_not_matching_pay; ?></span></label>
            <div class="col-sm-6 col-xs-12">
              <select class="form-control" name="axxion_pay_order_not_matching_pay" id="order_not_matching_pay">
               <?php foreach ($order_statuses as $order_status) : ?>
                <?php if ($order_status['order_status_id'] == $axxion_pay_order_not_matching_pay) : ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php else : ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php endif; ?>
              <?php endforeach; ?>
              </select>
            </div>
            <label class="col-sm-2 col-xs-6 control-label" for="axxion_pay_notify_order_not_matching_pay"><span data-toggle="tooltip" title="<?php echo $help_text_notify_me; ?>"><?php echo $text_notify_me; ?></span></label>
            <div class="col-sm-2 col-xs-6">
              <label class="radio-inline">
                <input type="radio" name="axxion_pay_notify_order_not_matching_pay" class="" value="1" <?php if($axxion_pay_notify_order_not_matching_pay == '1') echo 'checked'; ?> ><?php echo $text_yes; ?>
              </label>
              <label class="radio-inline">
                <input type="radio" name="axxion_pay_notify_order_not_matching_pay" class="" value="0" <?php if($axxion_pay_notify_order_not_matching_pay != '1') echo 'checked'; ?> ><?php echo $text_no; ?>
              </label>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 col-xs-12 control-label" for="entry_order_expired"><span data-toggle="tooltip" title='<?php echo $help_entry_order_expired; ?> '><?php echo $entry_order_expired; ?></span></label>
            <div class="col-sm-6 col-xs-12">
              <select class="form-control" name="axxion_pay_entry_order_expired" id="entry_order_expired">
               <?php foreach ($order_statuses as $order_status) : ?>
                <?php if ($order_status['order_status_id'] == $axxion_pay_entry_order_expired) : ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php else : ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php endif; ?>
              <?php endforeach; ?>
              </select>
            </div>
            <label class="col-sm-2 col-xs-6 control-label" for="axxion_pay_notify_order_expired"><span data-toggle="tooltip" title="<?php echo $help_text_notify_me; ?>"><?php echo $text_notify_me; ?></span></label>
            <div class="col-sm-2 col-xs-6">
              <label class="radio-inline">
                <input type="radio" name="axxion_pay_notify_order_expired" class="" value="1" <?php if($axxion_pay_notify_order_expired == '1') echo 'checked'; ?> ><?php echo $text_yes; ?>
              </label>
              <label class="radio-inline">
                <input type="radio" name="axxion_pay_notify_order_expired" class="" value="0" <?php if($axxion_pay_notify_order_expired != '1') echo 'checked'; ?> ><?php echo $text_no; ?>
              </label>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 col-xs-12 control-label" for="entry_order_waiting"><span data-toggle="tooltip" title='<?php echo $help_entry_order_waiting; ?> '><?php echo $entry_order_waiting; ?></span></label>
            <div class="col-sm-6 col-xs-12">
              <select class="form-control" name="axxion_pay_entry_order_waiting" id="entry_order_waiting">
               <?php foreach ($order_statuses as $order_status) : ?>
                <?php if ($order_status['order_status_id'] == $axxion_pay_entry_order_waiting) : ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php else : ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php endif; ?>
              <?php endforeach; ?>
              </select>
            </div>
            <label class="col-sm-2 col-xs-6 control-label" for="axxion_pay_notify_order_waiting"><span data-toggle="tooltip" title="<?php echo $help_text_notify_me; ?>"><?php echo $text_notify_me; ?></span></label>
            <div class="col-sm-2 col-xs-6">
              <label class="radio-inline">
                <input type="radio" name="axxion_pay_notify_order_waiting" class="" value="1" <?php if($axxion_pay_notify_order_waiting == '1') echo 'checked'; ?> ><?php echo $text_yes; ?>
              </label>
              <label class="radio-inline">
                <input type="radio" name="axxion_pay_notify_order_waiting" class="" value="0" <?php if($axxion_pay_notify_order_waiting != '1') echo 'checked'; ?> ><?php echo $text_no; ?>
              </label>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 col-xs-12 control-label" for="entry_order_waiting_block"><span data-toggle="tooltip" title='<?php echo $help_entry_order_waiting_block; ?> '><?php echo $entry_order_waiting_block; ?></span></label>
            <div class="col-sm-6 col-xs-12">
              <select class="form-control" name="axxion_pay_entry_order_waiting_block" id="entry_order_waiting_block">
               <?php foreach ($order_statuses as $order_status) : ?>
                <?php if ($order_status['order_status_id'] == $axxion_pay_entry_order_waiting_block) : ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php else : ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php endif; ?>
              <?php endforeach; ?>
              </select>
            </div>
            <label class="col-sm-2 col-xs-6 control-label" for="axxion_pay_notify_order_waiting_block"><span data-toggle="tooltip" title="<?php echo $help_text_notify_me; ?>"><?php echo $text_notify_me; ?></span></label>
            <div class="col-sm-2 col-xs-6">
              <label class="radio-inline">
                <input type="radio" name="axxion_pay_notify_order_waiting_block" class="" value="1" <?php if($axxion_pay_notify_order_waiting_block == '1') echo 'checked'; ?> ><?php echo $text_yes; ?>
              </label>
              <label class="radio-inline">
                <input type="radio" name="axxion_pay_notify_order_waiting_block" class="" value="0" <?php if($axxion_pay_notify_order_waiting_block != '1') echo 'checked'; ?> ><?php echo $text_no; ?>
              </label>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 col-xs-12 control-label" for="entry_order_processing"><span data-toggle="tooltip" title='<?php echo $help_entry_order_processing; ?> '><?php echo $entry_order_processing; ?></span></label>
            <div class="col-sm-6 col-xs-12">
              <select class="form-control" name="axxion_pay_entry_order_processing" id="entry_order_processing">
               <?php foreach ($order_statuses as $order_status) : ?>
                <?php if ($order_status['order_status_id'] == $axxion_pay_entry_order_processing) : ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php else : ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php endif; ?>
              <?php endforeach; ?>
              </select>
            </div>
            <label class="col-sm-2 col-xs-6 control-label" for="axxion_pay_notify_order_processing"><span data-toggle="tooltip" title="<?php echo $help_text_notify_me; ?>"><?php echo $text_notify_me; ?></span></label>
            <div class="col-sm-2 col-xs-6">
              <label class="radio-inline">
                <input type="radio" name="axxion_pay_notify_order_processing" class="" value="1" <?php if($axxion_pay_notify_order_processing == '1') echo 'checked'; ?> ><?php echo $text_yes; ?>
              </label>
              <label class="radio-inline">
                <input type="radio" name="axxion_pay_notify_order_processing" class="" value="0" <?php if($axxion_pay_notify_order_processing != '1') echo 'checked'; ?> ><?php echo $text_no; ?>
              </label>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 col-xs-12 control-label" for="entry_order_success"><span data-toggle="tooltip" title='<?php echo $help_entry_order_success; ?> '><?php echo $entry_order_success; ?></span></label>
            <div class="col-sm-6 col-xs-12">
              <select class="form-control" name="axxion_pay_entry_order_success" id="entry_order_success">
               <?php foreach ($order_statuses as $order_status) : ?>
                <?php if ($order_status['order_status_id'] == $axxion_pay_entry_order_success) : ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php else : ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php endif; ?>
              <?php endforeach; ?>
              </select>
            </div>
            <label class="col-sm-2 col-xs-6 control-label" for="axxion_pay_notify_order_success"><span data-toggle="tooltip" title="<?php echo $help_text_notify_me; ?>"><?php echo $text_notify_me; ?></span></label>
            <div class="col-sm-2 col-xs-6">
              <label class="radio-inline">
                <input type="radio" name="axxion_pay_notify_order_success" class="" value="1" <?php if($axxion_pay_notify_order_success == '1') echo 'checked'; ?> ><?php echo $text_yes; ?>
              </label>
              <label class="radio-inline">
                <input type="radio" name="axxion_pay_notify_order_success" class="" value="0" <?php if($axxion_pay_notify_order_success != '1') echo 'checked'; ?> ><?php echo $text_no; ?>
              </label>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
            <div class="col-sm-10">
              <input type="text" name="axxion_pay_sort_order" value="<?php echo $axxion_pay_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control"/>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-geo-zone"><?php echo $entry_geo_zone; ?></label>
            <div class="col-sm-10">
              <select name="axxion_pay_geo_zone_id" id="input-geo-zone" class="form-control">
                <option value="0"><?php echo $text_all_zones; ?></option>
                <?php foreach ($geo_zones as $geo_zone) { ?>
                <?php if ($geo_zone['geo_zone_id'] == $axxion_pay_geo_zone_id) { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="axxion_pay_gateway"><?php echo $text_payment_gateway; ?></label>
            <div class="col-sm-10">
              <select name="axxion_pay_gateway" id="axxion_pay_gateway" class="form-control">
                <?php if ($axxion_pay_gateway) { ?>
                <option value="itaxxion" selected="selected"><?php echo $text_axxion_portal; ?></option>
                <option value="cryptomkt"><?php echo $text_cryptomkt_portal; ?></option>
                <?php } else { ?>
                <option value="itaxxion"><?php echo $text_axxion_portal; ?></option>
                <option value="cryptomkt" selected="selected"><?php echo $text_cryptomkt_portal; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="axxion_pay_status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="axxion_pay_status" id="axxion_pay_status" class="form-control">
                <?php if ($axxion_pay_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>
