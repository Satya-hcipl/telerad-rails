// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require assets/global/plugins/jquery-validation/js/jquery.validate.min

//= require turbolinks
//= require jquery-fileupload
//= require nprogress
//= require jquery.cookie

//= require assets/global/plugins/jquery-migrate.min
//= require assets/global/plugins/jquery-ui/jquery-ui-1.10.3.custom.min

//= require assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown
//= require assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min
//= require assets/global/plugins/uniform/jquery.uniform.min
//= require assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min
//= require assets/global/plugins/select2/select2.min
//= require assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker
//= require assets/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min
//= require assets/global/plugins/clockface/js/clockface
//= require assets/global/plugins/bootstrap-daterangepicker/moment.min
//= require assets/global/plugins/bootstrap-daterangepicker/daterangepicker
//= require assets/global/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker
//= require assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min
//= require assets/global/scripts/metronic
//= require assets/admin/layout/scripts/layout
//= require assets/admin/layout/scripts/quick-sidebar
//= require assets/admin/layout/scripts/demo
//= require assets/admin/pages/scripts/table-advanced
//= require assets/admin/pages/scripts/form-validation
//= require assets/admin/pages/scripts/components-pickers

var initialize = function() {    
	Metronic.init(); // init metronic core components
	Layout.init(); // init current layout
	QuickSidebar.init();
	ComponentsPickers.init();
	Demo.init();
};

$(document).ready(initialize);
$(document).on("page:load", initialize);