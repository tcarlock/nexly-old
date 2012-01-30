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
  $('#inquiries-view').buttonset();

  $('a.ui-state-active').mouseover(function(){
       //$(this).removeClass('ui-state-active');
  }).mouseout(function(){
       $(this).addClass('ui-state-active');
  });

  $('#inquiries-view input[type=radio]').change(function() { $('#inquiries-view').submit(); });

  $('.archive-inquiry-link').click(function() {
    $(this).closest('li.biz-inquiry').block(getBlockUIOptions());
  });
});