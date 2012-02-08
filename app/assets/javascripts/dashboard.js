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
	$('.dash-side-tabs li.header').removeClass('active');
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

	// Toggle selected panel/tab
	$('#panel-side-tabs li.panel-toggle').click(function(){
		activatePanel($(this).attr('id'));
	});

	$('#panel-side-tabs li.tab-toggle').click(function(){
		$('#' + $(this).attr('ref')).slideToggle(350);
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
			  		updateHoverTabs();
				})
			});
	      	return false;
	    });
	};
	return $.setAjaxPagination();
});