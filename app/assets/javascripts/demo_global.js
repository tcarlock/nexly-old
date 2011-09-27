$(function(){
	$('#jixedbar').load('/demo/toolbar', function() {
		$("#jixedbar").jixedbar({
		    showOnTop: true,
		    transparent: true,
		    opacity: 0.5,
		    slideSpeed: "slow",
		    roundedCorners: false,
		    roundedButtons: false,
		    menuFadeSpeed: "slow",
		    tooltipFadeSpeed: "fast",
		    tooltipFadeOpacity: 0.5
		});
	});
});
