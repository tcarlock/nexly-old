$(function(){
	$('#quick-links li').hover(function(){
		$(this).find('ul').toggle();
	});

	$('#panel-tabs li.header').click(function(){
		target = $(this).children('a.toggle-link').attr('ref')
		if (target == 'settings-panel')
			$('#platforms').slideToggle(350);
		else {
			$('#panel-tabs li').removeClass('active');
			$(this).addClass('active');
			$('.dashboard-panel').hide();
			$('#' + target).fadeIn(350);
		}
	});
});