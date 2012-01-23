function activatePanel(tabId) {
	tab = $('#' + tabId);
	$('#panel-tabs li.header').removeClass('active');
	tab.addClass('active');
	$('.dashboard-panel').hide();
	$('#' + tab.attr('ref')).fadeIn(350);
	$.cookie('active-tab', tabId, { expires: 1 });
}

$(function(){
	// Select tab
	if($.cookie('active-tab') == null)
		activatePanel('analytics-tab');
	else
		activatePanel($.cookie('active-tab'));

	// Toggle selected panel OR show settings drop-panel
	$('#panel-tabs li.header').click(function(){
		if ($(this).attr('ref') == 'settings-panel')
			$('#platforms').slideToggle(350);
		else {
			activatePanel($(this).attr('id'));
		}
	});

	//Set up ajax pagination on reviews
	$.setAjaxPagination = function() {
	    return $('.pagination a').click(function(e) {
	    	$('#pending-reviews-outer').block();
	      	e.preventDefault();
				$.ajax({
				  type: 'GET',
				  url: $(this).attr('href'),
				  dataType: 'script',
				  success: (function() {
				    alert('success');
				  })
				});
	      	return false;
	    });
	};
	return $.setAjaxPagination();
});