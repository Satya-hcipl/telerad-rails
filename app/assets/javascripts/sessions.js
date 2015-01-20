//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require assets/global/plugins/jquery-migrate.min
//= require assets/global/plugins/uniform/jquery.uniform.min
//= require assets/admin/pages/scripts/form-validation
//= require assets/global/scripts/metronic
//= require assets/admin/layout/scripts/layout
//= require assets/admin/layout/scripts/demo

var initialize = function() {    
	Metronic.init(); // init metronic core components
	Layout.init(); // init current layout
	Demo.init();
};

$(document).ready(initialize);
$(document).on("page:load", initialize);