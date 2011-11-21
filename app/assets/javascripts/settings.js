$(function() {
	$('#admin-tabs').tabs();

	$('#fb-pages-link').colorbox();

	$('input.page-select').live("change", function() {
		$.post('/platforms/' + $('#platform-id').val() + '/pages/' + $(this).attr('id') + '/toggle_publishing');
	});

	if ($('#display-pages').val() == 'true') {
		$.fn.colorbox({href: $('#fb-pages-link').attr('href')});
	};
	
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