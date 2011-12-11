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
            backgroundColor: '#D8D5D5', 
           	opacity: .8
       	}
   	}
}

$(function() {
	$('#fb-pages-link').colorbox();
	$('.screen-cap').colorbox();

	$('input.page-select').live("change", function() {
		$.post('/platforms/' + $('#platform-id').val() + '/pages/' + $(this).attr('id') + '/toggle_publishing');
	});

	$('#toolbar-activation').change(function() {
		$.post('/settings/toggle_toolbar_activation');
	});

	$('#review-enabling').change(function() {
		$.post('/settings/toggle_public_reviews');
	});
	
	$('#rec-enabling').change(function() {
		$.post('/settings/toggle_public_recommendations');
	});
	
	if ($('#display-fb-pages').val() == 'true') {
		$.fn.colorbox({href: $('#fb-pages-link').attr('href')});
	};
	
	$('.integration-panels a').click(function() {
		if(!$(this).siblings('div.contents').is(':visible')) {
			$('.integration-panels div.contents').slideUp(200);
			$(this).siblings('div.contents').slideDown(350);

			$("#tab-plugins div.details-text div").hide();
			$("#" + $(this).attr('rel')).fadeIn(900);
		}
	});

	$('.deauth-platform').click(function() {
		$(this).parent().block(getBlockUIOptions());
	});
	
	// $('.integration-panels a').toggle(function() {
	// 	var contentPanel = $(this).siblings('div.contents');
	// 	contentPanel.slideDown(350, function() {
	// 		$('body').animate({scrollTop: contentPanel.offset().top - 5}, 800);
	// 	});
	// }, function() {
	// 	var contentPanel = $(this).siblings('div.contents');
	// 	contentPanel.slideDown(350, function() {
	// 		$('body').animate({scrollTop: contentPanel.offset().top - 5}, 800);
	// 	});
	// 	
	// 	if(!isHardPaused)
	// 		startAutoNav();
	// 	$('body').animate({scrollTop: '0px'}, 800, function() {
	// 		//$('#sign-up-tab').effect("scale", { percent: 200, origin: ['top','left'] }, 300);
	// 		$('#signup-pane-inner').slideUp(350);
	// 	});
	// });
	
	$('textarea.integration-script')
	.mouseup(function(e){
	    // fixes safari/chrome problem
	    e.preventDefault();
	})
	.focus(function(e){
	    $(this).select();
	})
	.click(function(e){
	    $(this).select();
	});
});