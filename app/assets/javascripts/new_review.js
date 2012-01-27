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
  $('#stars-outer').stars({cancelShow:false});

  $('input.create').click(function() {
    if($('#stars-outer').data('stars').options.value == 0)
      $('#review-rating-error').show();
  });

  $('#new_review').validate({
    debug: false,
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
        $('#new_review').ajaxSubmit({target: '#new-review-outer', success: function() {
          $('#new-review-outer').unblock();
          $('#new-review-outer').replaceWith('<span class="submitted">Your review has been sent. Thanks!<span>')
        }});
        return false;
      }
    }
  });
});