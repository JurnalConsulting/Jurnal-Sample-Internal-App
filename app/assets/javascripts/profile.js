//= require jurnal_integration
//= require jquery.poshytip
//= require jquery.tooltipster.min


$(document).ready(function(){

  $('.tooltip-trigger-settings').poshytip({
    className: 'tip-twitter',
    showTimeout: 1,
    alignTo: 'target',
    alignX: 'right',
    alignY: 'center',
    offsetX: 10,
    offsetY: 5,
    allowTipHover: false,
    fade: false,
    slide: false
  });

  $('#profile-access-token').text(JurnalIntegration.get_access_token());

  $('.fetch-customer').click(function(){
    window.location.replace(window.location.origin +"/welcomes/sync_response"+ "?access_token=" + JurnalIntegration.get_access_token() + "&type=customers");
  });

  $('.fetch-product').click(function(){
    window.location.replace(window.location.origin +"/welcomes/sync_response"+ "?access_token=" + JurnalIntegration.get_access_token() + "&type=products");
  });

  $('.enable-webhook').click(function(){
    window.location.replace(window.location.origin +"/welcomes/enable_webhook"+ "?access_token=" + JurnalIntegration.get_access_token());
  });

  $('.webhook-history-log').click(function(){
    window.location.replace(window.location.origin +"/welcomes/webhook_history_log"+ "?access_token=" + JurnalIntegration.get_access_token());
  });

  $('.add-sales-invoice').click(function(){
    window.location.replace(window.location.origin +"/welcomes/new_sales_invoice"+ "?access_token=" + JurnalIntegration.get_access_token());
  });

  $('.delete-webhook').click(function(){
    window.location.replace(window.location.origin +"/welcomes/delete_webhook"+ "?access_token=" + JurnalIntegration.get_access_token());
  });



});