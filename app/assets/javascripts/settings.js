function getBlockUIOptions() {
   	return {
   	    message: '<img src="/assets/throbber/loading_orange.gif" />',
        centerX: true,
       	centerY: true,
   	    css: { 
            border: '0px',
           	backgroundColor: 'transparent',
            cursor: 'default'
       	},
   	    overlayCSS: { 
            backgroundColor: '#F7F7F7', 
           	opacity: .8
       	}
   	}
}

$(function() {
	$('.screen-cap').colorbox();

	$('a.toggle-feature').live("click", function() {
		$(this).closest('li').block(getBlockUIOptions());
		$.post('/settings/toggle_feature/' + $(this).attr('data-feature-id'));
	});

	//Config Facebook-page selection
	$('#fb-pages-link').colorbox();

	if ($('#display-fb-pages').val() == 'true') {
		$.fn.colorbox({href: $('#fb-pages-link').attr('href')});
	};

	$('input.page-select').live("change", function() {
		$.post('/platforms/' + $('#platform-id').val() + '/pages/' + $(this).attr('id') + '/toggle_publishing');
	});

	//Platform-disabling
	$('.deauth-platform').click(function() {
		$(this).parent().block(getBlockUIOptions());
	});
	
	//Config panel show/hide
	$('li > a', '#plugin-admin-panels').click(function() {
		if(!$(this).siblings('div.contents').is(':visible')) {
			$('li > div.contents', '#plugin-admin-panels').slideUp(200);
			$(this).siblings('div.contents').slideDown(350);

			$("#tab-plugins div.details-text div").hide();
			$("#" + $(this).attr('rel')).fadeIn(900);
		}
	});

	//Enable color pickers for toolbar design
	$('div.color-picker-preview', '#color-palette').each(function() {
		var previewTab = $(this);
		var valField = $('input[name="' + $(this).attr('id') + '"]');

		previewTab.css('backgroundColor', '#' + valField.val());

		$(this).ColorPicker({
			onShow: function (colpkr) {
				$(colpkr).fadeIn(500);
				previewTab.ColorPickerSetColor(valField.val());
				return false;
			},
			onHide: function (colpkr) {
				$(colpkr).fadeOut(500);
				return false;
			},
			onChange: function (hsb, hex, rgb) {
				previewTab.css('backgroundColor', '#' + hex);
				valField.val(hex);
			}
		});	
	});

	$('.color-field').change(function(){
		$('#' + $(this).attr('name')).css('backgroundColor', '#' + $(this).val());
	})

	$('#update_toolbar_settings').submit(function() {
		$('#update_toolbar_settings').block(getBlockUIOptions());
	})
	
	//Auto-select script in textboxes
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