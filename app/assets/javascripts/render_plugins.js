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

		//show quick menu on click
		$("span.menu_title a").click(function() {
			link = $(this);

			if($(this).attr('data-toolbar-id') != undefined)
				toolbar = $('#' + $(this).attr('data-toolbar-id'));

			menu = $(this).siblings(".quickmenu");

			if(menu.is(':hidden')){ //if quick menu isn't visible
				$(".quickmenu").hide(); //Hide all other menus
				$(".btn-container").hide(); //Hide all other toolbars
				
				menu.fadeIn(); //show menu

				//Load appropriate page into quickmenu (if necessary)
				if(link.attr('href') != "#")
					menu.load(link.attr('href'));
				
				//expandFrame();
				if(toolbar != null)
					$(toolbar).fadeIn();
			}
			else if ($(".quickmenu").is(':visible')) { //if quick menu is visible
				menu.fadeOut("fast"); //hide menu on click
				//collapseFrame();
				if(toolbar != null)
					toolbar.fadeOut();
			}
			return false;
		});
		
		//hide menu on casual click on the page
		$(parent.document).click(function() {
			$(".quickmenu").fadeOut("fast");
			$(".btn-container").fadeOut();
		});

		$('.quickmenu').click(function(e) {
			e.stopPropagation(); //use .stopPropagation() method to avoid the closing of quick menu panel clicking on its elements
		});

		//don't jump to #id link anchor
		$("a.link-button, a.menutit, span.showbar a").click(function(e) {
			e.preventDefault();
		});

		$('a.link-button').click(function(e) {
			window.open($(this).attr("href"));
			e.preventDefault();
			e.stopPropagation();
		});
	});
}

try {
	if ($(".nexly-content").length > 0) {
		loadPages();
	}

	var tbWrapper = $("#nexly-toolbar", parent.document);

	if (tbWrapper.attr('data-tb-enabled') == "true")
    	loadToolbar(tbWrapper);
}
catch(e) {
	//Whoops...die gracefully	
}