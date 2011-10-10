$(function(){
	function pauseAutoNav() {
		$('#panel-play-pause').addClass('paused');
		$('#viewport').cycle('pause');
	}
	
	function startAutoNav() {
		$('#panel-play-pause').removeClass('paused');
		$('#viewport').cycle('resume');
	}
	
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
					$('.panel-nav-btn, #sign-up-tab, #viewport .content, #viewport .text').fadeTo(2000, 1, function() {
						$('#viewport').cycle('resume').hover(function() {
							pauseAutoNav();
						}, function() {
							startAutoNav();
						});
					});
				});
			});
		});
	};
	
	// $('#play-demo').click(function() {
	// 	$('#viewport').cycle('pause').animate({ height: 325 });
	// 	$(this).fadeOut(250);
	// 	$('demo-outer').fadeIn(250);
	// 	player = document.getElementsById('commoncraft-embed');
	// 	player.addModelListener('STATE', 'stateMonitor');
	// });
	
	$('#panel-play-pause').toggle(pauseAutoNav, startAutoNav);
	
	$('.flash').each(function() {
		$(this).delay(500).show('slide', { direction: 'down' }, 250).delay(3500).hide('slide', { direction: 'down' }, 250);
	});
	
	$('#logo').hover(function() {
		$('#home-icon').show();
	}, function() {
		$('#home-icon').hide();
	});
	
	$('#viewport').cycle({
	    speed:  1500, 
	    timeout: 7000,
		fx:  'scrollHorz',
		prev: '#panel-nav-prev',
		next: '#panel-nav-next',
	    pager:  '#timeline-nav',
		pagerAnchorBuilder: function(index, slide) {
			var label;
			
			switch (index)
			{
				case 0: 
					label = "Intro";
					break;
				case 1: 
					label = "Watch a Demo";
					break;
				case 2:	
					label = "Our Future Plans";
					break;
				default: 
					label = "Error";
					break;
			}
			return '<a href="#" class="tab-' + index + '">' + label + '</a>'; 
		}
	}).cycle('pause');
	
	$('ul.standard-list li').hoverIntent(hoverIntentConfig('div.btns-tab-small'));
	
	$('#sign-up-tab').toggle(function() {
			pauseAutoNav();
			$('#signup-pane-inner').slideDown(350, function() {
				$('html, body').animate({scrollTop: $('#signup-pane-inner').offset().top - 5}, 800);
			});
		}, function() {
			startAutoNav();
			$('html, body').animate({scrollTop: '0px'}, 800, function() {
				$('#signup-pane-inner').slideUp(350);
			});
	});
	
	$('li', '#highlights').hoverIntent({    
	    over: function() {
			var element = $(this);
			element.find("div.content").fadeIn(250);
			if((element.offset().top + element.height()) > $(window).height())
				$('html, body').animate({ scrollTop: element.offset().top }, 4000);
		}, 
	    timeout:0,
	    out: function() {
			$(this).find("div.content").fadeOut(250);
		}
	});
	
	$('a.control-link', 'div.btns-tab form').click(function() {
		$(this).closest('form').submit();
	    return false; 
	});
});