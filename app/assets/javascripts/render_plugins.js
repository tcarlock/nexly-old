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
            backgroundColor: '#fff', 
           	opacity: .8
       	}
   	}
}

function loadPages() {
	var pluginContainer = $(".nexly-content"); 

	pluginContainer.load("http://nexly-demo.heroku.com/plugins/render_content_page/?app=" + pluginContainer.attr('data-app-id') + "&network=" + pluginContainer.attr('data-network'));	
}

function loadToolbar(tbElement) {
	tbElement.load("http://nexly-demo.heroku.com/plugins/toolbar/?network=" + tbElement.attr("data-network"), function(){
		//hide toolbar and make visible the 'show' button
		$("span.downarr a").click(function() {
		    $("#toolbar").slideToggle("fast");
		    $("#toolbarbut").fadeIn("slow");
		});

		//show toolbar and hide the 'show' button
		$("span.showbar a").click(function() {
			$("#toolbar").slideToggle("fast");
		    $("#toolbarbut").fadeOut();
		});

		//show tooltip when the mouse is moved over a list element
		$(".leftside > ul > li").hover(function() {
				$(this).find("div").fadeIn("fast").show(); //add 'show()'' for IE
		    $(this).mouseleave(function () { //hide tooltip when the mouse moves off of the element
		        $(this).find("div").hide();
		    });
		});

		//Render canvas on click
		$("a.menutit").click(function() {
			//parent.document.getElementById('nexly-canvas-frame').src = "http://localhost:3000/plugins/reviews/?network=" + tbElement.attr('data-network');
			//parent.document.getElementById('nexly-canvas').style.display="block";

			link = $(this);
			canvas = $('#nexly-canvas', parent.document);
			canvasFrame = $('#nexly-canvas-frame', parent.document);
			
			if($(this).attr('data-btn-group-id') != undefined)
				buttonGroup = $('#' + $(this).attr('data-btn-group-id'));

			//Set address
			//$('#nexly-canvas-frame', parent.document).attr('src', "http://localhost:3000/plugins/reviews/?network=" + tbElement.attr('data-network'));

			if (link.attr('href') == canvasFrame.attr('src')) {   //Canvas already loaded with correct url
				if (canvas.is(':visible')) {
					canvas.fadeOut("fast");

					if(buttonGroup != null)
						buttonGroup.fadeOut();
				}
				else {
					if(buttonGroup != null)
						buttonGroup.fadeIn();

					canvas.fadeIn();
				}
			}
			else {
				//Set canvas and toolbar visibility
				if (canvas.is(':hidden'))
					canvas.fadeIn();

				//canvas.block(getBlockUIOptions());

				//Load appropriate page into quickmenu
				if (link.attr('href') != "#")
					canvasFrame.attr('src', link.attr('href'));

				//Hide all other toolbars
				$(".btn-container").hide(); 

				if(buttonGroup != null)
					buttonGroup.fadeIn();

				canvas.animate({ width: $(this).attr('data-canvas-width') || 400 }, 350, function() {canvas.unblock();});
			}

			return false;
		});
		
		//hide menu on casual click on the page
		$(parent.document).click(function() {
			$("#nexly-canvas", parent.document).fadeOut("fast");
			$(".btn-container").fadeOut();
		});

		$('#nexly-canvas').click(function(e) {
			e.stopPropagation(); //use .stopPropagation() method to avoid the closing of canvas itself
		});
	});
}

$(function() {
	try {
		if ($(".nexly-content").length > 0) {
			loadPages();
		}

		var tbWrapper = $("#nexly-toolbar");

		if (tbWrapper.attr('data-tb-enabled') == "true")
	    	loadToolbar(tbWrapper);
	}
	catch(e) {
		//Whoops...die gracefully	
	}
});