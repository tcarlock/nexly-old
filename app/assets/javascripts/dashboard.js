function getBlockUIOptions() {
   	return {
   	    message: '<img src="/assets/throbber/loading_orange.gif" />',
        centerX: true,
       	centerY: true,
   	    css: { 
            border: '0px',
           	backgroundColor: 'transparent'
       	},
   	    overlayCSS: { 
            backgroundColor: '#fff', 
           	opacity: .8
       	}
   	}
}
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
		else
			activatePanel($(this).attr('id'));
	});

	//Set up ajax pagination on reviews
	$.setAjaxPagination = function() {
	    return $('.pagination a').live('click', function(e) {
	    	var pagingSelector = '';

	    	switch ($.cookie('active-tab')) {
	    		case 'reviews-tab':
	    			pagingSelector = '#pending-reviews-outer'
	    			break;
	    		case 'inquiries-tab':
	    			pagingSelector = '#active-inquiries-outer'
	    			break;
	    	}

	    	$(pagingSelector).block(getBlockUIOptions());
	      	e.preventDefault();
			$.ajax({
				type: 'GET',
				url: $(this).attr('href'),
				dataType: 'script',
				success: (function() {
			  		$(pagingSelector).unblock();
				})
			});
	      	return false;
	    });
	};
	return $.setAjaxPagination();
});