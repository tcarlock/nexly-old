$(function(){
	$('.approve-review-link').click(function() {
		$(this).closest('li.biz-review').block();
	});
});