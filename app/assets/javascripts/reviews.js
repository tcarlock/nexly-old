function getBlockUIOptions() {
   	return {
   	    message: '<img src="/assets/throbber/loading_orange.gif" />',
        centerX: true,
       	centerY: true,
   	    css: { 
            border: '0px',
           	backgroundColor: 'transparent',
            cursor: 'default'
       	},
   	    overlayCSS: { 
            backgroundColor: '#fff', 
           	opacity: .8
       	}
   	}
}

$(function() {
	$('.approve-review-link, .reject-review-link', parent.document).click(function() {
		$(this).closest('li.biz-review').block(getBlockUIOptions());
	});
});