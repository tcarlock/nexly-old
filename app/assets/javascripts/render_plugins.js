function getBlockUIOptions() {
   	return {
   	    message: '<img src="/assets/throbber/grey-bar.gif" />',
        centerX: true,
       	centerY: true,
   	    css: { 
            border: '0px',
           	backgroundColor: 'transparent',
            cursor: 'default'
       	},
   	    overlayCSS: { 
            backgroundColor: 'transparent', 
           	opacity: 1
       	}
   	}
}

function initPages() {
	var pluginContainer = $('.nexly-page');

	pluginContainer.load('http://nexly-demo.heroku.com/plugins/render_content_page/?app=' + pluginContainer.attr('data-app-id') + '&network=' + pluginContainer.attr('data-network'));
}

function initToolbar(tbElement) {
	//hide toolbar and make visible the 'show' button
	$('span.downarr a').click(function() {
	    $('#toolbar').slideToggle('fast', function(){
	    	$('#toolbarbut').slideToggle('fast');
	    });
	});

	//show toolbar and hide the 'show' button
	$('span.showbar a').click(function() {
		$('#toolbarbut').slideToggle('fast', function(){
	    	$('#toolbar').slideToggle('fast');
	    });
	});

	//show tooltip when the mouse is moved over a list element
	$('.leftside > ul > li').hover(function() {
			$(this).find('div').fadeIn('fast').show(); //add 'show()'' for IE
	    $(this).mouseleave(function () { //hide tooltip when the mouse moves off of the element
	        $(this).find('div').hide();
	    });
	});

	$('#nexly-canvas-frame').load(function() {
        $('#nexly-canvas').unblock();
    });

	//Render canvas on click
	$('a.menutit').click(function() {
		renderCanvas($(this));
		return false;
	});
	
	//hide menu on casual click on the page
	$(parent.document).click(function() {
		$('#nexly-canvas', parent.document).fadeOut('fast');
		$('.btn-container').fadeOut();
	});

	$('#nexly-canvas').click(function(e) {
		e.stopPropagation(); //use .stopPropagation() method to avoid the closing of canvas itself
	});
}

function displayTab(tabReference) {
	renderCanvas($('#' + tabReference));
}

function renderCanvas(linkRef) {
	url = linkRef.attr('href')
	canvas = $('#nexly-canvas');
	canvasFrame = $('#nexly-canvas-frame');
	
	// if($(this).attr('data-btn-group-id') != undefined)
	// 	buttonGroup = $('#' + $(this).attr('data-btn-group-id'));

	if (url == canvasFrame.attr('src')) {   //Canvas already loaded with correct url
		if (canvas.is(':visible')) {
			canvas.fadeOut('fast');

			// if(buttonGroup != null)
			// 	buttonGroup.fadeOut();
		}
		else {
			// if(buttonGroup != null)
			// 	buttonGroup.fadeIn();

			canvas.fadeIn();
		}
	}
	else {
		//Set canvas and toolbar visibility
		if (canvas.is(':hidden'))
			canvas.fadeIn();

		canvasFrame.hide();

		//Load appropriate page into quickmenu
		canvasFrame.load(function (){
			canvas.unblock();
		    canvasFrame.fadeIn();
		}).attr('src', url);

		canvas.animate({ width: linkRef.attr('data-canvas-width') || 400 }, 250, function() {
			canvas.block(getBlockUIOptions());
		});
	}
}

$(function() {
	try {
		if ($('.nexly-page').length > 0)
			initPages();

		var tbWrapper = $('#nexly-toolbar');

		if (tbWrapper.attr('data-tb-enabled') == 'true')
	    	initToolbar(tbWrapper);

	    //Check for querystring flags for auto-showing tabs
		var url = location.href

		if (url.indexOf('?') != -1) {
			var qs = url.split('?')[1];
			var qsArray = null;

			if (qs.indexOf('&') == -1)
				qsArray = [qs];
			else
				qsArray = qs.split['&'];

			for (i in qsArray)
				if (qsArray[i].split('=')[0] == 'nexlyCanvasRef')
					displayTab(qsArray[i].split('=')[1]);
		}
	}
	catch(e) {
		//Whoops...die gracefully	
	}
});