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

$(function() {
	$('.approve-review-link, .reject-review-link').click(function() {
		$(this).closest('li.biz-review').block(getBlockUIOptions());
	});
});