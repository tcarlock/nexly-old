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
  $('#new_inquiry').validate({
    debug: false,
    rules: {
      "inquiry[name]": {required: true},
      "inquiry[email]": {required: true, email: true},
      "inquiry[details]": {required: true}
    },
    messages: {
      "inquiry[name]": {required: "Required field"},
      "inquiry[email]": {required: "Required field", email: "Please enter a valid email"},
      "inquiry[details]": {required: "Required field"}
    },
    submitHandler: function(form) {
      if($('#new_inquiry').valid()) {
        $('#new-inquiry-outer').block(getBlockUIOptions());
        $('#new_inquiry').ajaxSubmit({success: function() {
          $('#new-inquiry-outer').unblock();
          $('#new-inquiry-outer').replaceWith('<span class="submitted">Your inquiry has been submitted. Thanks!<span>')
        }});
        return false;
      }
    }
  });
});