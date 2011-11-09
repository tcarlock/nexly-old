# The embed code is compressed and minified using the closure compiler.
# Please run ./compile to build the embed code.
#
# Lines starting with #<space> will be removed during compilation.
# Lines starting with #<A> will be included only for target A.
# A line can be included in multiple targets if the target names
# are separated with '|', e.g. #spacebook|myface alert('hello');

/**
 * If the code is included twice, the second instance will not adversely
 * affect the first.  
 *   @param {Object} params - see bottom of this file for the definition
 *       of params.  It contains the partner settings for the Nexly Bar. 
 */
window.Nexly || (function(params) {
	var win = window;
	
	/**
	* Return early for extensions if either:
	*	we are on http(s)?://www.nexly.com/
	*	we are on a *.dev.nexly.com page
	*	the page is iframed (top window is not this window)
	*	the page is a popout (win.opener exists)
	*/
	
	#everywhere|dogfood	if (win.location.toString().match(/^https?:\/\/www\.nexly\.com\/?(messenger)?\/?$/)
	#everywhere|dogfood		|| win.location.hostname.toString().match(/\.dev\.nexly\.com$/)
	#everywhere|dogfood		|| win.location.hostname == '127.0.0.1' || win.location.hostname == 'localhost'
	#everywhere|dogfood		|| win.location.protocol != 'http:'
	#everywhere|dogfood		|| win.top != win) { return; }
	
	/**
	 * This is the exported Nexly API function 'Nexly' that lives in the 
	 * global scope.  Partners can execute API functions by calling
	 *     Nexly("<name of API method>", arg1, arg2, ...);
	 * Some partners also set custom parameters on the Nexly object for
	 * controlling certain aspects of the bar.
	 * 
	 * The Nexly object also acts as an onload handler for Nexly.  To
	 * be notified when the Nexly Bar loads, a partner can call:
	 *     Nexly(function() {
	 *         ... this function runs once the Nexly Bar loads ...
	 *     });
	 */
	
	var Nexly = win.Nexly = win.Nexly || function() { (Nexly._ = Nexly._ || []).push(arguments); },
		
		doc = document,
		body = 'body',
		bodyEl = doc[body],
		caller;
	
	/**
	 * If the embed code is placed (incorrectly) in the HEAD of a document,
	 * we will try initializing the bar again once the BODY element exists. 
	 */
	
	if(!bodyEl) {
		caller = arguments.callee;
		return setTimeout(function() { caller(params); }, 100);
	}
	
	/**
	 * These properties are used for logging certain events that happen
	 * while the Nexly Bar loads.  We use these to monitor, tune, and
	 * optimize the performance of the Nexly Bar to ensure it doesn't 
	 * block partner sites and minimize the impact of loading the bar.
	 */
	Nexly.$ = {0: +new Date};
	Nexly.T = function(key) {
		Nexly.$[key] = new Date - Nexly.$[0];
	};
	
	/**
	 * This is the internal version number of the Nexly Bar embed code.
	 */
	Nexly.v = 4;
	
	/**
	 * Storing string values for certain properties improves the minification of
	 * the code when using the closure compiler.
	 */
	var load = 'load',
		appendChild = 'appendChild',
		createElement = 'createElement',
		src = 'src',
		lang = 'lang',
		network = 'network',
		domain = 'domain',
		
		/**
		 * Create placeholder DOM where the Nexly Bar will go.
		 */
		nexlyDiv = doc[createElement]('div'),
		el = nexlyDiv[appendChild](doc[createElement]('m')),
		iframe = doc[createElement]('iframe'),
		
		/**
		 * Here we listen for the load event of the page to monitor page 
		 * load times.  This must be done in the embed code since the bar
		 * itself defers to the page for loading priority.  In some cases,
		 * this means the bar will load after the page loads, in which case
		 * we wouldn't be able to measure this value.
		 */
		addEventListener = 'addEventListener',
		attachEvent = 'attachEvent',
		documentS = 'document',
		contentWindow = 'contentWindow',
		domainSrc,
		onload = function() {
			Nexly.T(load);
			Nexly(load);
		};
	
	if (win[addEventListener]) {
		win[addEventListener](load, onload, false);
	} else {
		win[attachEvent]('on' + load, onload);
	}
	
	/**
	 * Prepare the placeholder DOM (make it invisible) and insert it
	 * into the DOM.
	 */
	nexlyDiv.style.display = 'none';

	/**
	 * For the extensions, we'd like to append the #nexly div to the bottom of
	 * the page so that we're drawn on top of elements with the same z-index.
	 * Unfortunately, there is an IE issue when appending elements with
	 * innerHTML'ed contents while parsing happening. This special case should
	 * be safe for extensions, in which the DOM has finished loading at the time
	 * of embed code execution.
	 */
	#everywhere|dogfood bodyEl[appendChild](nexlyDiv).id = 'nexly';
	#dashboard|nexly-site|spacebook|myface bodyEl.insertBefore(nexlyDiv, bodyEl.firstChild).id = 'nexly';
	iframe.frameBorder = "0";
	iframe.id = "nexly-iframe";
	iframe.allowTransparency = "true";
	el[appendChild](iframe);

	/**
	 * Try to start writing into the blank iframe. In IE, this will fail if document.domain has been set, 
	 * so fail back to using a javascript src for the frame. In IE > 6, these urls will normally prevent 
	 * the window from triggering onload, so we only use the javascript url to open the document and set 
	 * its document.domain
	 */
	try {
		iframe[contentWindow][documentS].open();
	} catch(e) {
		params[domain] = doc[domain];
		domainSrc = "javascript:var d=" + documentS + ".open();d.domain='" + doc.domain + "';";
		iframe[src] = domainSrc + "void(0);";
	}

	/**
	 * html() builds the string for the HTML of the iframe.
	 */	
	function html() {
		return [
			'<', body, ' onload="var d=', documentS, ";d.getElementsByTagName('head')[0].",
			appendChild, '(d.', createElement, "('script')).", src, "='//",
			#spacebook|myface /dev\.nexly\.com/.test(document.location.host)?document.location.host : params.host || 'cim.nexly.com',
			#nexly-site '{{ bar_hostname }}',
			#dashboard 'cim.nexly.com',
			#everywhere|dogfood window.NexlyExtensionOptions && NexlyExtensionOptions.domain ||
				#everywhere 'www.nexly.com',
				#dogfood 'alpha.nexly.com',
			'/cim?iv=', Nexly.v, '&',
			network, '=', params[network],
			#nexly-site '&v={{ bar_version }}',
			#everywhere|dogfood '&extension=true',
			#spacebook|myface params['barType'] == 'extension' || params['barType'] == 'mini' ? '&'+params['barType']+'=true' : '',
			params[lang] ? '&' + lang + '=' + params[lang] : '',
			params[domain] ? '&' + domain + '=' + params[domain] : '',
			'\'"></', body, '>'
		].join('');
	};

	/**
	 * Set the HTML of the iframe. In IE 6, the document.domain from the iframe src hasn't had time to 
	 * "settle", so trying to access the contentDocument will throw an error. Luckily, in IE 7 we can 
	 * finish writing the html with the iframe src without preventing the page from onloading
	 */
	try {
		var d = iframe[contentWindow][documentS];
		d.write(html());
		d.close();
	} catch(e) {
		iframe[src] = domainSrc + 'd.write("' + html().replace(/"/g, '\\"') + '");d.close();';
	}

	/**
	 * All done! Record the time it took to run this code (should be < 10ms).
	 */
	Nexly.T(1);
})({
	#spacebook|myface|nexly-site host: (function(){var match=document.cookie.match(/build=([\w\.-]+)/); return match ? match[1] : null})(),
	#spacebook|myface barType: (function(){var match=document.cookie.match(/barType=([\w]+)/); return match ? match[1] : null})(),
	#spacebook  network: 'spacebook'
	#myface     network: 'myface'
	#nexly-site network: 'nexly-site'
	#everywhere|dogfood network: 'everywhere'
	#dashboard  network: '%(partner)s'
});