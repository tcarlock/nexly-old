$(function(){
	function hoverIntentConfig(selector) {
		return {    
		    over: function() {
				$(this).find(selector).slideDown(250);
			}, 
		    timeout:0,
		    out: function() {
				$(this).find(selector).fadeOut(250);
			}
		};
	}
	
	$('.flash').each(function() {
		$(this).delay(500).show('slide', { direction: 'down' }, 250).delay(3500).hide('slide', { direction: 'down' }, 250);
	});
	
	$('#logo').hover(function() {
		$('#home-icon').show();
	}, function() {
		$('#home-icon').hide();
	});
	
	$('ul.standard-list li').hoverIntent(hoverIntentConfig('div.btns-tab-small'));
	
	$('a.control-link', 'div.btns-tab form').click(function() {
		$(this).closest('form').submit();
	    return false; 
	});

	$('#admin-tabs').tabs();
	
	$('#submit-feedback').colorbox({transition:'fade', speed:500, modal: true});
		
	// Required for link redirects
	$('a[data-popup]').live('click', function(e) { 
		window.open($(this)[0].href); 
		e.preventDefault(); 
	});
});