try {
	$("#nexly-toolbar", parent.document).load("/plugins/toolbar/?network=" + $("#nexly-toolbar", parent.document).attr("data-network"), function(){
		//hide toolbar and make visible the 'show' button
		$("span.downarr a", parent.document).click(function() {
		    $("#toolbar", parent.document).slideToggle("fast");
		    $("#toolbarbut", parent.document).fadeIn("slow");
		});

		  //show toolbar and hide the 'show' button
		$("span.showbar a", parent.document).click(function() {
			$("#toolbar", parent.document).slideToggle("fast");
		    $("#toolbarbut", parent.document).fadeOut();
		});

		//show tooltip when the mouse is moved over a list element
		$(".leftside > ul > li", parent.document).hover(function() {
				$(this).find("div").fadeIn("fast").show(); //add 'show()'' for IE
		    $(this).mouseleave(function () { //hide tooltip when the mouse moves off of the element
		        $(this).find("div").hide();
		    });
		});

		//show quick menu on click
		$("span.menu_title a", parent.document).click(function() {
			var toolbar = null;

			if($(this).attr('data-toolbar-id') != undefined)
				toolbar = $('#' + $(this).attr('data-toolbar-id'), parent.document);

			var menu = $(this).siblings(".quickmenu");

			if(menu.is(':hidden')){ //if quick menu isn't visible
				$(".quickmenu", parent.document).hide(); //Hide all other menus
				menu.fadeIn("fast"); //show menu on click
				//expandFrame();
				if(toolbar != null)
					$(toolbar).fadeIn(1000);
			}
			else if ($(".quickmenu", parent.document).is(':visible')) { //if quick menu is visible
				menu.fadeOut("fast"); //hide menu on click
				//collapseFrame();
				if(toolbar != null)
					toolbar.fadeOut(500);
			}
			return false;
		});

		//hide menu on casual click on the page
		$(parent.document).click(function() {
			$(".quickmenu", parent.document).fadeOut("fast");
			$(".btn_container", parent.document).fadeOut(500);
		});

		$('.quickmenu', parent.document).click(function(e) {
			e.stopPropagation(); //use .stopPropagation() method to avoid the closing of quick menu panel clicking on its elements
		});

		//don't jump to #id link anchor
		$("a.link-button, a.menutit, span.showbar a", parent.document).click(function(e) {
			e.preventDefault();
		});

		$('a.link-button', parent.document).click(function(e) {
			window.open($(this).attr("href"));
			e.preventDefault();
			e.stopPropagation();
		});
	});
}
catch(e) {
	//Whoops...die gracefully
}