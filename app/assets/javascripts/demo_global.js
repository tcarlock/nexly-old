$(function(){
	$('#jixedbar').load('/demo/toolbar', function() {
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
		$("ul#social li").hover(function() {
				$(this).find("div").fadeIn("fast").show(); //add 'show()'' for IE
		    $(this).mouseleave(function () { //hide tooltip when the mouse moves off of the element
		        $(this).find("div").hide();
		    });
		});
		
		//show quick menu on click
		$("span.menu_title a").click(function() {
			if($(".quickmenu").is(':hidden')){ //if quick menu isn't visible
				$(".quickmenu").fadeIn("fast"); //show menu on click
			}
			else if ($(".quickmenu").is(':visible')) { //if quick menu is visible
				$(".quickmenu").fadeOut("fast"); //hide menu on click
			}
		});

		//hide menu on casual click on the page
		$(document).click(function() {
			$(".quickmenu").fadeOut("fast");
		});
		
		$('.quickmenu').click(function(event) {
			event.stopPropagation(); //use .stopPropagation() method to avoid the closing of quick menu panel clicking on its elements
		});

		//don't jump to #id link anchor
		$(".facebook, .twitter, .delicious, .digg, .rss, .stumble, .menutit, span.downarr a, span.showbar a").click(function() {
			return false;
		});
	});
});
