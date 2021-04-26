
//= require jquery
//= require jquery_ujs
//= require popper.min
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.en-GB.js

//= require moment
//= require bs4-datetime-picker


  $(document).ready(function(){
    $('.datepicker').datepicker({
      format: 'dd/mm/yyyy',
      startDate: '0d'
    });
  });


  $(document).ready(function(){
    $('#datetimepicker').datetimepicker();
  });
