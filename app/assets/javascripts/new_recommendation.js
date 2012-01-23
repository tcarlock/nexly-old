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
  $('#new_recommendation').validate({
    debug: false,
    rules: {
      "recommendation[name]": {required: true},
      "recommendation[email]": {required: true, email: true}
    },
    messages: {
      "recommendation[name]": {required: "Required field"},
      "recommendation[email]": {required: "Required field", email: "Please enter a valid email"}
    },
    submitHandler: function(form) {
      if($('#new_recommendation').valid()) {
        $('#new-rec-outer').block(getBlockUIOptions());
        $('#new_recommendation').ajaxSubmit({target: '#new-rec-outer', success: function() {
          $('#new-rec-outer').unblock();
          $('#new-rec-outer').replaceWith('<span class="submitted">Your recommendation has been submitted.<span>')
        }});
        return false;
      }
    }
  });
});