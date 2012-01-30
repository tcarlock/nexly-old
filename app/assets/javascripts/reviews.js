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
  //Change index view
  $('#reviews-view').buttonset();

  $('a.ui-state-active').mouseover(function(){
       //$(this).removeClass('ui-state-active');
  }).mouseout(function(){
       $(this).addClass('ui-state-active');
  });

  $('#reviews-view input[type=radio]').change(function() { $('#reviews-view').submit(); });

	$('.approve-review-link, .reject-review-link').click(function() {
		$(this).closest('li.biz-review').block(getBlockUIOptions());
	});

  $('.delete-request-link').click(function() {
    $(this).closest('li.review-request').block(getBlockUIOptions());
  });
});