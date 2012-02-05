$(function(){
	var isHardPaused = false;
	
	function pauseAutoNav() {
		$('#panel-play-pause').addClass('paused');
		$('#viewport').cycle('pause');
	}
	
	function startAutoNav() {
		$('#panel-play-pause').removeClass('paused');
		$('#viewport').cycle('resume');
	}
	
	function hideNavControls() {
		$('.panel-nav-btn, #sign-up-tab').fadeOut(500);
	}
		
	function showNavControls() {
		$('.panel-nav-btn, #sign-up-tab').fadeIn(500);
	}

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

	if($('#storyboard-banner').length == -1) {
		$('#pre').delay(2000).fadeOut(1000, function() {
			$('#storyboard-banner').animate({ width: 400, right: 275 });
			$('#post').fadeIn(1500, function() {
				$('#storyboard-banner').delay(1500).animate({ top:0, right:0, opacity: 0 }, 1000, function() {
					$('.panel-nav-btn, #sign-up-tab, #viewport .content, #viewport .text').fadeTo(2000, 1, function() {
						$('#viewport').cycle('resume').hover(function() {
							if(!isHardPaused)
								pauseAutoNav();
						}, function() {
							if(!isHardPaused)
								startAutoNav();
						});
					});
					$('#pre').remove();
					$('#post').remove();
				});
			});
		});
	};

	$('.panel-nav-btn, #sign-up-tab, #viewport .content, #viewport .text').fadeTo(1000, 1);
	
	$('#panel-play-pause').toggle(function() {
		isHardPaused = true;
		pauseAutoNav();
	}, function() {
		isHardPaused = false;
		startAutoNav();
	});

	$('#play-demo').click(function() {
		isHardPaused = true;
		pauseAutoNav();
		hideNavControls();

		$('div.text, div.content', '#demo-panel').fadeOut(350, function() {
			$('#viewport').animate({ height: '400px' }, function() {
				$('#demo-outer').show();
			});
		});
	});

	$('#close-demo').click(function() {
		$('#demo-outer').fadeOut(250, function() {
			$('#viewport').animate({ height: '340px' });
			$('div.text, div.content', '#demo-panel').fadeIn(350, function() {
				isHardPaused = false;
				startAutoNav();
				showNavControls();
			});
		});
	});
	
	$('#viewport').cycle({
	    speed:  1000, 
	    timeout: 10000,
		fx:  'scrollHorz',
		prev: '#panel-nav-prev',
		next: '#panel-nav-next',
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
	
	$('#sign-up-tab').toggle(function() {
		pauseAutoNav();
		$('#signup-pane-inner').slideDown(350, function() {
			$('body').animate({scrollTop: $('#signup-pane-inner').offset().top - 5}, 800);
		});
	}, function() {
		if(!isHardPaused)
			startAutoNav();
		$('body').animate({scrollTop: '0px'}, 800, function() {
			$('#signup-pane-inner').slideUp(350);
		});
	});
	
	$('li', '#highlights ul').hoverIntent({    
	    over: function() {
			var element = $(this);
			element.find("div.content").slideDown(250);
			// if((element.offset().top + element.height()) > $(window).height())
			// 	$('body').animate({ scrollTop: element.offset().top }, 800);
		},
	    timeout:0,
	    out: function() {
			$(this).find("div.content").fadeOut(250);
		}
	});
});