function initToolbar() {
	$("#nexly-toolbar").load("http://localhost:3000/plugins/toolbar/?network=" + $("#nexly-toolbar").attr("data-network"), function(){
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
			var toolbar = null;
			
			if($(this).attr('data-toolbar-id') != undefined)
				toolbar = $('#' + $(this).attr('data-toolbar-id'));

			var menu = $(this).siblings(".quickmenu");
		
			if(menu.is(':hidden')){ //if quick menu isn't visible
				$(".quickmenu").hide(); //Hide all other menus
				menu.fadeIn("fast"); //show menu on click
				expandFrame();
				if(toolbar != null)
					toolbar.fadeIn(1000);
			}
			else if ($(".quickmenu").is(':visible')) { //if quick menu is visible
				menu.fadeOut("fast"); //hide menu on click
				collapseFrame();
				if(toolbar != null)
					toolbar.fadeOut(500);
			}
		});

		//hide menu on casual click on the page
		$(document).click(function() {
			$(".quickmenu").fadeOut("fast");
			$(".btn_container").fadeOut("fast");
			collapseFrame();
		});
	
		$('.quickmenu').click(function(event) {
			event.stopPropagation(); //use .stopPropagation() method to avoid the closing of quick menu panel clicking on its elements
		});

		//don't jump to #id link anchor
		$(".facebook, .twitter, .delicious, .digg, .rss, .stumble, .menutit, span.downarr a, span.showbar a").click(function() {
			return false;
		});
	
		//Init command buttons
		//$('#new-review-btn').colorbox({transition:'fade', speed:500, modal: true});
		//$('#new-rec-btn').colorbox({transition:'fade', speed:500, modal: true});
	
		// $('#new-review-btn').click(function(e) {
		// 	window.open($(this).attr("href"));
		// 	e.preventDefault();
		// });

		$('a.link-button').click(function(e) {
			window.open($(this).attr("href"));
			e.preventDefault();
		});
		
		// $('#new-review-btn').click(function(e) {
		// 	var tb = document.getElementById('nexly-toolbar');
		// 	tb.addEventListener("mouseover",expandFrame,false)
		// 	$.fn.colorbox({transition:'fade', innerWidth:425, innerHeight:344, speed:500, modal:true});
		// 	e.preventDefault();
		// });
	});
}
function expandFrame() {
	var tb = document.getElementById('nexly-toolbar');
	parent.document.getElementById("nexly-iframe").style.height="100%"	
}
function collapseFrame() {
	var tb = document.getElementById('nexly-toolbar');
	parent.document.getElementById("nexly-iframe").style.height="47px"	
}

initToolbar();

// var tb = document.getElementById('nexly-toolbar');
// tb.addEventListener("mouseover",function(){parent.document.getElementById("nexly-iframe").style.height="100%"},false)
// tb.addEventListener("mouseout",function(){parent.document.getElementById("nexly-iframe").style.height="47px"},false);