$(function(){
	function hoverIntentConfig(selector) {
		return {    
		    over: function() {
				$(this).find(selector).fadeIn(250);
			}, 
		    timeout:0,
		    out: function() {
				$(this).find(selector).fadeOut(250);
			}
		};
	};
	
	if($('#storyboard-banner').length == 1) {
		$('#pre').delay(2000).fadeOut(1000, function() {
			$('#storyboard-banner').animate({ width: 350, right: 300 });
			$('#post').fadeIn(1500, function() {
				$('#storyboard-banner').delay(1500).animate({ top:0, right:0, opacity: 0 }, 1000, function() {
					$('#timeline-nav, #sign-up-tab, #viewport .content, #viewport .text').fadeTo(2000, 1);
				});
			});
		});
	};
	
	$('.flash').each(function() {
		$(this).delay(500).show('slide', { direction: 'down' }, 250).delay(3500).hide('slide', { direction: 'down' }, 250);
	});
	
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
	

	$('ul.standard-list li').hoverIntent(hoverIntentConfig('div.btns-tab-small'));
	
	$('#sign-up-tab').toggle(function() {
			$('#signup-pane-inner').slideToggle(350);
			$('html, body').animate({scrollTop: $('#signup-pane-inner').offset().top - 5}, 800);
		}, function() {
			$('html, body').animate({scrollTop: '0px'}, 800);
			$('#signup-pane-inner').slideToggle(350);
	});
	
	$('li', '#highlights').hoverIntent(hoverIntentConfig('div.content'));
		
	$('#account-nav').toggle(function() {
		$('#account-links').slideDown(250);
		$(this).addClass('active');
	}, function() {
		$('#account-links').slideUp(250);
		$(this).removeClass('active');
	});
	
	$('a.control-link', 'div.btns-tab form').click(function() {
		$(this).closest('form').submit();
	    return false; 
	});
});