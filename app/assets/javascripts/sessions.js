var initialize = function() {    
	Metronic.init(); // init metronic core components
	Layout.init(); // init current layout
	Login.init();
	QuickSidebar.init();
	ComponentsPickers.init();
	Demo.init();
};

$(document).ready(initialize);
$(document).on("page:load", initialize);