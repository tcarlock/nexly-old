$(function(){
	$('#post').delay(1000).animate({ backgroundColor: '#3595D4'}, 1000, function() {
		$('#storyboard-banner').delay(1000).animate({ top:5, right:5, fontSize: '.5em', opacity:0 }, { duration: 750 });

		$('#timeline-nav').fadeTo(2000, 1);
		$('#sign-up-tab').fadeTo(2000, 1);
		$('#viewport .content').delay(1000).fadeTo(2000, 1);
		$('#viewport .text').delay(1000).fadeTo(2000, 1);		
	})
	
	$('.flash').each(function() {
		$(this).delay(3000).hide('slide', { direction: 'down' }, 250);
	})
	
	$('#logo').hover(function() {
		$('#home-icon').show();
	}, function() {
		$('#home-icon').hide();
	});
	
	$('#viewport').cycle({
	    fx:     'scrollLeft', 
	    speed:  1000, 
	    timeout: 0, 
	    pager:  '#timeline-nav',
		pagerAnchorBuilder: function(index, slide) {
			var label;
			
			switch (index)
			{
				case 0: 
					label = "Our Services";
					break;
				case 1: 
					label = "Our Market Focus";
					break;
				case 2:	
					label = "Our Technology Bets";
					break;
				default: 
					label = "Error";
					break;
			}
			return '<a href="#" class="tab-' + index + '">' + label + '</a>'; 
		}
	});
	
	$('#sign-up-tab').toggle(function() {
			$('#signup-pane-inner').slideToggle(350);
			$('html, body').animate({scrollTop: $('#signup-pane-inner').offset().top - 5}, 800);
		}, function() {
			$('html, body').animate({scrollTop: '0px'}, 800);
			$('#signup-pane-inner').slideToggle(350);
	});
	
	$('#account-nav').toggle(function() {
		$('#account-links').slideDown(250);
		$(this).addClass('active');
	}, function() {
		$('#account-links').slideUp(250);
		$(this).removeClass('active');
	});
	
	$('a.control-link').click(function() {
		$(this).closest('form').ajaxSubmit();
	    return false; 
	});
});