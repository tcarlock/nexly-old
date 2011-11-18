$(function() {
	$('#admin-tabs').tabs();

	$('#fb-pages-link').colorbox();
	
	$('input.page-select').change(function() {
		$.post('/platforms/' + $('#platform-id').attr('value') + '/pages/' + $(this).attr('id') + '/toggle_publishing');
	});
	
	$('#disable-fb-link').click(function() {
		$('#disable-fb-form').submit();
		return false;
	});
	
	$('textarea.toolbar-script')
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