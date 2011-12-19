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

$(function() {
	$('.approve-review-link, .reject-review-link').click(function() {
		$(this).closest('li.biz-review').block(getBlockUIOptions());
	});

  $('#stars-outer').stars({cancelShow:false});

  $('input.create').click(function() {
    if($('#stars-outer').data('stars').options.value == 0)
      $('#review-rating-error').show();
  });

  $('#new_review').validate({
    debug: true,
    rules: {
      "review[name]": {required: true},
      "review[email]": {required: true, email: true},
      "review[details]": {required: true}
    },
    messages: {
      "review[name]": {required: "Required field"},
      "review[email]": {required: "Required field", email: "Please enter a valid email"},
      "review[details]": {required: "Required field"}
    },
    submitHandler: function(form) {
      if($('#new_review').valid() && $('#stars-outer').data('stars').options.value != 0) {
        $('#new-review-outer').block(getBlockUIOptions());
        $('#new_review').ajaxSubmit({target: '#new-review-outer', success: function () {$('#new-review-outer').unblock()}});
        return false;
      }
    }
  });
});