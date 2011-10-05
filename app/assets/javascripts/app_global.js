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

	function stateMonitor(obj)
	{
	if(obj.newstate == 'COMPLETED')
	{
		alert('test');
	document.getElementById("placeholder").style.display="none";
	}
	};
	
	if($('#storyboard-banner').length == 1) {
		$('#pre').delay(2000).fadeOut(1000, function() {
			$('#storyboard-banner').animate({ width: 350, right: 300 });
			$('#post').fadeIn(1500, function() {
				$('#storyboard-banner').delay(1500).animate({ top:0, right:0, opacity: 0 }, 1000, function() {
					$('.panel-nav-btn, #sign-up-tab, #viewport .content, #viewport .text').fadeTo(2000, 1, function() {
						$('#viewport').cycle('resume').hover(function() {
							$(this).cycle('pause');
						}, function() {
							$(this).cycle('resume');
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
	    timeout: 6000,
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
			$('#viewport').cycle('pause')
			$('#signup-pane-inner').slideToggle(350);
			$('html, body').animate({scrollTop: $('#signup-pane-inner').offset().top - 5}, 800);
		}, function() {
			$('#viewport').cycle('pause')
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