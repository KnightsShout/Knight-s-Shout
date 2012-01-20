/**
 * random required functions
 */
var JSON = JSON || {};

JSON.stringify = JSON.stringify || function (obj) {
	var t = typeof (obj);
	if (t != "object" || obj === null) {
		if (t == "string") obj = '"'+obj+'"';
		return String(obj);
	}
	else {
		var n, v, json = [], arr = (obj && obj.constructor == Array);
		for (n in obj) {
			v = obj[n]; t = typeof(v);
			if (t == "string") v = '"'+v+'"';
			else if (t == "object" && v !== null) v = JSON.stringify(v);
			json.push((arr ? "" : '"' + n + '":') + String(v));
		}
		return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
	}
};

function intval(mixed_var, base){
    var tmp;

    var type = typeof(mixed_var);

    if (type === 'boolean') {
        return +mixed_var;
    } else if (type === 'string') {
        tmp = parseInt(mixed_var, base || 10);
        return (isNaN(tmp) || !isFinite(tmp)) ? 0 : tmp;
    } else if (type === 'number' && isFinite(mixed_var)) {
        return mixed_var | 0;
    } else {
        return 0;
    }
}

function addslashes(str){
    return (str + '').replace(/[\\"']/g, '\\$&').replace(/\u0000/g, '\\0');
}

function stripslashes(str){
    return (str + '').replace(/\\(.?)/g, function (s, n1) {
        switch (n1) {
        case '\\':
            return '\\';
        case '0':
            return '\u0000';
        case '':
            return '';
        default:
            return n1;
        }
    });
}

function is_array(mixed){
	return typeof(mixed) == 'object';
}

function is_defined(mixed){
	return typeof(mixed) != 'undefined';
}

function is_string(mixed){
	return typeof(mixed) == 'string';
}

function set_title(title){
	if (is_string(title))
	{
		KS.title_base = document.title = title;
	}
	else if (is_array(title))
	{
		document.title = title[0];
	}
}

function include(file){
	if (!is_defined(file))
		return;
	try {
		if (file.substr(-4) == '.css')
		{
			var child = document.createElement('link');
			child.rel = 'stylesheet';
			child.type = 'text/css';
			child.href = file;
		}
		else if (file.substr(-3) == '.js')
		{
			var child = document.createElement('script');
			child.type = 'text/javascript';
			child.src = file;
		}
		else
		{
			return;
		}
		try {
			document.getElementsByTagName('head')[0].appendChild(child);
		} catch(e) {
			try {
				console.log("[KS] Failed including " + file + ".");
			} catch(e) {}
		}
	} catch(e) {}
}

jQuery.fn.extend
({
    removeCss: function(cssName) {
        return this.each(function() {
            var curDom = $(this);
            jQuery.grep(cssName.split(","),
                    function(cssToBeRemoved) {
                        curDom.css(cssToBeRemoved, '');
                    });
            return curDom;
        });
    }
});

var console = window.console || {
        log: function(string){},
        error: function(string){},
        debug: function(string){}
};

var Popupify = {
        active: -1,
        version: '1.0.0',
        setup: {
                'opacity': 0.7,
                'width': 500,
                'height': 400,
                'padding': 2,
                'animate': true,
                'animation_dim_speed': 300,
                'animate_fancy': true,
                'enableDim': true
        },
        as_ajax: true,
        as_html: false,
        is_defined: function(input){
                return typeof (input) !== "undefined";
        },
        intval: function(mixed_var, base){
                var tmp;
                var type = typeof(mixed_var);
                
                if (type === 'boolean') {
                        return +mixed_var;
                } else if (type === 'string') {
                        tmp = parseInt(mixed_var, base || 10);
                        return (isNaN(tmp) || !isFinite(tmp)) ? 0 : tmp;
                } else if (type === 'number' && isFinite(mixed_var)) {
                        return mixed_var | 0;
                } else {
                        return 0;
                }
        },
        client: {
                width: 0,
                height: 0,
                getSpecs: function(){
                        var myWidth = 0, myHeight = 0;
                        
                        if (typeof (window.innerWidth) == 'number')
                        {
                                myWidth = window.innerWidth;
                                myHeight = window.innerHeight;
                        } else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
                                myWidth = document.documentElement.clientWidth;
                                myHeight = document.documentElement.clientHeight;
                        } else if (document.body && (document.body.clientWidth || document.body.clientHeight)) {
                                myWidth = document.body.clientWidth;
                                myHeight = document.body.clientHeight;
                        }
                        
                        this.width = Popupify.intval(myWidth);
                        this.height = Popupify.intval(myHeight);
                }
        },
        activate: function(setup){
                if (this.active === true){
                        return;
                }
                if (typeof (jQuery) == 'undefined'){
                        this.active = false;
                        console.error("[POPUPIFY] Popupify requires the jQuery library.");
                        return;
                }
                
                this.client.getSpecs();
                this.active = true;
                
                if (typeof (setup.opacity) != 'undefined'){
                        this.setup.opacity = setup.opacity;
                }
                if (typeof (setup.width) != 'undefined'){
                        this.setup.width = setup.width;
                }
                if (typeof (setup.height) != 'undefined'){
                        this.setup.height = setup.height;
                }
                if (typeof (setup.padding) != 'undefined'){
                        this.setup.padding = setup.padding;
                }
                if (typeof (setup.animate) != 'undefined'){
                        this.setup.animate = setup.animate;
                }
                if (typeof (setup.animation_dim_speed) != 'undefined'){
                        this.setup.animation_dim_speed = setup.animation_dim_speed;
                }
                if (typeof (setup.animate_fancy) != 'undefined'){
                        this.setup.animate_fancy = setup.animate_fancy;
                }
                if (typeof (setup.enableDim) != 'undefined'){
                        this.setup.enableDim = setup.enableDim;
                }
                
                $('body').append('<div id="popupify-dim"></div>');
                $("#popupify-dim").css({'opacity': this.setup.opacity}).hide();
                $('body').append('<div id="popupify-container" align="center"></div>');
                $("#popupify-container").css({'width': this.client.width, 'height': this.client.height}).append('<div id="popupify-container-bg"></div>');
                $("#popupify-container-bg").css({'width': this.setup.width, 'height': this.setup.height, 'max-height': this.setup.height, 'padding': this.setup.padding, 'margin-top': Popupify.intval(((this.client.height - Popupify.intval(this.setup.height)) / 2))});
                $("#popupify-container-bg").append('<div id="popupify-container-cancel"><a href="javascript:Popupify.doHide();">&nbsp;X&nbsp;</a></div><div id="popupify-container-fg" align="left"></div>');
                $("#popupify-container-cancel").css({'margin-left': Popupify.intval(this.setup.width) -8, 'margin-top': -15});
                
                $(window).resize(function(){
                        Popupify.client.getSpecs();
                        $("#popupify-container").css({'width': Popupify.client.width, 'height': Popupify.client.height});
                        $("#popupify-container-bg").css({'margin-top': Popupify.intval(((Popupify.client.height - Popupify.intval(Popupify.setup.height)) / 2))});
                });
        },
        configure: function(setup){
                if (typeof (setup.opacity) != 'undefined'){
                        this.setup.opacity = setup.opacity;
                }
                if (typeof (setup.width) != 'undefined'){
                        this.setup.width = setup.width;
                }
                if (typeof (setup.height) != 'undefined'){
                        this.setup.height = setup.height;
                }
                if (typeof (setup.padding) != 'undefined'){
                        this.setup.padding = setup.padding;
                }
                if (typeof (setup.animate) != 'undefined'){
                        this.setup.animate = setup.animate;
                }
                if (typeof (setup.animation_dim_speed) != 'undefined'){
                        this.setup.animation_dim_speed = setup.animation_dim_speed;
                }
                if (typeof (setup.animate_fancy) != 'undefined'){
                        this.setup.animate_fancy = setup.animate_fancy;
                }
                if (typeof (setup.enableDim) != 'undefined'){
                        this.setup.enableDim = setup.enableDim;
                }
        },
        doDim: function(){
                if (this.setup.animate){
                        $("#popupify-dim").fadeIn(this.setup.animation_dim_speed);
                } else {
                        $("#popupify-dim").show();
                }
        },
        doLighten: function(){
                if (this.setup.animate){
                        $("#popupify-dim").fadeOut(this.setup.animation_dim_speed);
                } else {
                        $("#popupify-dim").hide();
                }
        },
        doLocate: function(){
                var nHeight = this.intval($("#popupify-container-bg").css('height'));
                
                if (this.setup.animate){
                        $("#popupify-container-bg").animate({
                                'margin-top': this.intval((this.client.height - nHeight) / 2)
                        }, 200);
                } else {
                        $("#popupify-container-bg").css({'margin-top': this.intval((this.client.height - nHeight) / 2)});
                }
        },
        curPopup: {abort: function(){}},
        doPopup: function(popup){
                if (typeof (popup.type) == 'undefined'){
                        return;
                }
                
                if (this.setup.enableDim){
                        this.doDim();
                }
                $("#popupify-container").show();
                $("#popupify-container-fg").removeCss('height').html('<div id="popupify-loading"></div>');
                
                if (this.setup.animate_fancy){
                        this.doLocate();
                }
                
                if (popup.type == this.as_ajax){
                        if (typeof (popup.ajax) == 'undefined'){
                                this.doHide();
                                return;
                        }
                        
                        this.curPopup = $.ajax(popup.ajax).always(function(){
                                if (this.intval ($("#popupify-container-fg").css('height')) < this.setup.height){
                                        $("#popupify-container-bg").removeCss('height');
                                }
                                this.doLocate();
                        });
                } else if (popup.type == this.as_html){
                        if (typeof (popup.html) == 'undefined'){
                                this.doHide();
                                return;
                        }
                        
                        $("#popupify-container-fg").html(popup.html);
                        if (this.intval ($("#popupify-container-fg").css('height')) < this.setup.height){
                                $("#popupify-container-bg").removeCss('height');
                        }
                        this.doLocate();
                }
        },
        doHide: function(){
                if (this.setup.enableDim){
                        this.doLighten();
                }
                this.curPopup.abort();
                $("#popupify-container").hide();
        }
};

/**
 * new url manipulation
 */
var ks_url = new function(){
	this.started = false;
	this.isAvailable = false;
	this.foreground = [];
	this.background = [];
	this.start = function(){
		this.started = true;
		this.isAvailable = true;
	};
	this.fake = function(title, url, type){
		if (type == 1)
		{
			this.foreground = [title, url];
		}
		else if (type == 0)
		{
			this.background = [title, url];
		}
		
		try {
			window.history.pushState({}, title, url);
		} catch(e) {
			console.log("[KS URL] Failed manipulating history.");
		}
	};
	this.fForeground = function(){
		this.fake(this.foreground[0], this.foreground[1], 2);
	};
	this.fBackground = function(){
		this.fake(this.background[0], this.background[1], 2);
	}
};

/**
 * new comet
 * - no longer using long-polling.
 */
var ks_comet = new function(){
	this.ready = false;
	this.pcount = 0;
	this.processes = new Array();
	this.start = function(){
		console.log("[KS COMET] Initializing...");
		$('body').append('<div id="ks_comet" style="visibility: hidden;"></div>');
		this.ready = true;
		console.log("[KS COMET] Done.");
	};
	this.watch = function(url, method, data, name, interval){
		console.log("[KS COMET] Creating new Process...");
		if (!this.ready){
			this.start();
		}
		this.pcount++;
		console.log("[KS COMET] Assigning Process as '" + name + "'/'" + this.pcount +"'...");
		this.processes[name] = new function(){
			this.isActive = false;
			this.pId = 0;
			this.pName = null;
			this.pURL = null;
			this.pMethod = null;
			this.pData = null;
			this.pInterval = 0;
			this.pStart = function(id, url, method, data, name, interval){
				this.pId = id;
				this.pName = name;
				this.pURL = url;
				this.pMethod = method;
				this.pData = data;
				this.isActive = true;
				this.pInterval = interval;
			};
			this.pThread = {};
			this.pWatch = function(that){
				/*console.log('pWatch() called.');*/
				if (that.isActive !== true){
					console.log('!this.isActive' + that.isActive + "/" + that.pId);
					return;
				}
				console.log("[KS COMET][#'" + that.pName + "'" + that.pId + "] Watching...");
				that.pThread = $.ajax({
					url: that.pURL,
					method: that.pMethod,
					data: that.pData,
					dataType: "html",
					success:
						function(js){
							$("#ks_comet").append(js);
							console.log("[KS COMET][#'" + that.pName + "'" + that.pId + "] Done.");
						},
					failure:
						function(error){
							console.log('[COMET failed.] ' + error);
							console.log("[KS COMET][#'" + that.pName + "'" + that.pId + "] !!! FAILED !!!");
						},
					complete:
						function(){
							setTimeout(that.pWatch, intval(that.pInterval), that);
						}
				});
			};
		};
		
		var p = name;
		var i = interval !== null ? interval : 1500;
		
		this.processes[p].pStart(this.pcount, url, method, data, name, i);
		var p_ = this.processes[p];
		console.log("[KS COMET] Process #" + this.pcount + " created.");
		this.processes[p].pWatch(p_);
	};
	this.disconnect = function(){
		$.each(this.processes, function(key, comet){
			comet.isActive = false;
			try {
				comet.pThread.abort();
				console.log("[KS COMET][#" + comet.pName + "/" + comet.pId + "] Disconnecting.")
			} catch (e) {
				console.log("[KS COMET][disconnect] Failed aborting ajax. /" + key);
			}
		});
	};
};

/**
 * new anchor ajax system
 */
var ks_anchors = new function(){
	this.p = null;
	this.active = false;
	this.current = null;
	this.history = [];
	this.start = function(){
		$('body').append('<div id="ks_anchors" style="visibility: hidden;"></div>');
		this.active = true;
		this.p = window.setInterval(ks_anchors.aCheck, 80);
	};
	this.enable = function(){
		this.active = true;
	};
	this.disable = function(){
		this.active = false;
	};
	this.aSet = function(){
		this.current = document.location.hash;
	};
	this.aCheck = function(){
		if (!this.active){return;}
		if (document.location.hash.substr(1,2) == "!")
		{
			if (this.current !== document.location.hash)
			{
				this.current = document.location.hash;
				if (!is_defined (this.current))
					return;
				
				var url = "/ajax" + this.current.substr(2);
				$.ajax({
					url: url,
					dataType: "html",
					success:
						function(js){
							this.history.push(this.current);
							$("#ks_anchors").append(js);
						}
				});
			}
		}
	};
	this.back = function(a){
		document.location.hash = this.history[this.history.length-(2+a)];
	};
	this.stop = function(){
		this.active = false;
		window.clearInterval(this.p);
	};
};

/**
 * deprecated comet
 */ 
/*
function COMET_abort(){
	var _comet = new COMET({});
	if (_comet.prototype.live)
	{
		_comet.prototype.ajaxRequest.abort();
	}
	_comet.prototype.live = false;
}

window.onunload = COMET_abort;
*/

/*
var __comet = 0;

function COMET(setup){
	this.live = false;
	this.config = setup;
	this.deliberate = false;
	this.watch = function(){
		if (this.live == true)
			return 'already_connected';
		if (!is_defined(this.config.isPulled))
			this.config.isPulled = true;
		if (!is_defined(this.config._url))
			return false;
		this.callback = this.config._callback;
		if (!is_defined(this.config._method))
			return false;
		if (!is_defined(this.config._data))
			return false;
		__comet++;
		this.deliberate = false;
		this.config.d = __comet;
		$('body').append('<div id="_comet_" class="_comet"></div>');
		this.live = true;
		this.request();
		return true;
	};
	this.request = function(){
		if (this.live !== true)
		{
			if (this.deliberate)
			{
				alert ('[COMET stopped working.] Please, refresh the Page.');
			}
			return false;
		}
		
		var ajaxRequest = null;
		
		try {
			ajaxRequest = new XMLHttpRequest();
		} catch(e) {
			try {
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} catch(e) {
				try {
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} catch(e) {
					alert ('[COMET could not be initialized.]');
					this.live = false;
				}
			}
		}
		
		ajaxRequest.onreadystatechange = function(){
			if (ajaxRequest.readyState == 4)
			{
				$("#_comet_").append(ajaxRequest.responseText);
				if (this.config.isPulled)
				{
					this.request();
				}
				else
				{
					setTimeout (this.request, 1500);
				}
			}
		};
		
		ajaxRequest.open(this.config._method, this.config._url + (this.config._data !== null ? ("?" + this.config._data) : ""), true);
		ajaxRequest.send(null);
		
		return true;
	};
	this.disconnect = function(state){
		this.deliberate = state;
		this.live = false;
	};
}
*/

var KS = {
    secure_key: null,
    _init: function(){
        this.getWindowSize();
	/**
	 * note that we need not check for msie, because frankly it's blocked anyways.
	 */
	this.browser.client = navigator.userAgent.toLowerCase().indexOf('firefox') > -1 ? 'firefox' : 'mozilla';
	if (this.browser.client == 'firefox')
	{
		include('/themes/knightsshout/css/style_ff.css');
	}
	/**
	 * old KSPopups
	 */
        $('body').prepend(
                        '<div style="position:absolute;top:0px;left:0px;z-index:99;"><div class="dim"></div></div>' +
                        '<div class="popup" align="center" style="z-index:100;">' +
                        '   <div id="ppbg" valign="middle" align="center">' +
                        '       <div style="position: absolute; margin-left: 585px; margin-top: 3px; padding: 1px; background: #000; border: 1px solid #666; color: #fff;" id="ppcl" align="right"><b><a href="javascript:KS.doHidePopup();" style="color: #fff;">X</a></b></div>' +
                        '       <script type="text/javascript">$("#ppcl").animate({opacity: 0.8}, 300).hide();</script>' +
                        '       <div class="ppfg" id="' + this.popupDivC + '" align="left">' +
                        '       </div>' +
                        '   </div>' +
                        '</div>'
                         );
        this.alignPopup();
        $(".dim").animate({opacity: 0.85}).hide();
	/*$("#ppbg").css({height: '500px'});*/
	/**
	 * New KS Popupify
	 */
	
	include('http://beta.knightsshout.com/resources/release/css/popupify.css');
	Popupify.activate({padding: 0, opacity: 0.8, width: 650, height: 500, animate_fancy: false});
	Popupify.doLocate();
    },
    getWindowSize: function(){
        var myWidth = 0, myHeight = 0;
        
        if (typeof (window.innerWidth) == 'number')
        {
            myWidth = window.innerWidth;
            myHeight = window.innerHeight;
        }
        else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight))
        {
            myWidth = document.documentElement.clientWidth;
            myHeight = document.documentElement.clientHeight;
        }
        else if (document.body && (document.body.clientWidth || document.body.clientHeight))
        {
            myWidth = document.body.clientWidth;
            myHeight = document.body.clientHeight;
        }
        
        this.browser.width = myWidth;
        this.browser.height = myHeight;
    },
    browser: {
        width: 0,
        height: 0,
	client: null
    },
    notifications_total: 0,
    notifications_friends: 0,
    notifications_other: 0,
    domain: 'knightsshout.com',
    logged_in: 'undefined',
    lang: [],
    doLoadItem: function(){
        
    },
    menu: {
        active: false,
        doNormalize: function(){
            if (this.active == true)
            {
                $("#dropdown").hide();
                $("#account-section").removeClass('tab-active').addClass('tab');
                $("#dropdown-servers").hide();
                $("#servers-section").removeClass('tab-active').addClass('tab');
                $("#dropdown-comm").hide();
                $("#comm-section").removeClass('tab-active').addClass('tab');
                this.active = false;
            }
        },
        doAccount: function(){
            if ($("#dropdown").is(":hidden"))
            {
                this.doNormalize();
                this.active = true;
                $("#dropdown").show();
                $("#account-section").removeClass('tab').addClass('tab-active');
            }
            else
            {
                this.active = false;
                $("#dropdown").hide();
                $("#account-section").removeClass('tab-active').addClass('tab');
            }
        },
        doServers: function(){
            if ($("#dropdown-servers").is(":hidden"))
            {
                this.doNormalize();
                this.active = true;
                $("#dropdown-servers").show();
                $("#servers-section").removeClass('tab').addClass('tab-active');
            }
            else
            {
                this.active = false;
                $("#dropdown-servers").hide();
                $("#servers-section").removeClass('tab-active').addClass('tab');
            }
        },
        doCommunity: function(){
            if ($("#dropdown-comm").is(":hidden"))
            {
                this.doNormalize();
                this.active = true;
                $("#dropdown-comm").show();
                $("#comm-section").removeClass('tab').addClass('tab-active');
            }
            else
            {
                this.active = false;
                $("#dropdown-comm").hide();
                $("#comm-section").removeClass('tab-active').addClass('tab');
            }
        }
    },
    doPreSearch: function(){
        alert ('fu');
	
	/*
	if (this.logged_in !== true || that.value.length < 3)
            return;
	*/
    },
    doSuccess: function(strElement, strSuccess){
        $(strElement).removeClass('error').removeClass('loading').addClass('success').html(strSuccess).hide().fadeIn(300);
    },
    doLoad: function(strElement){
        $(strElement).removeClass('success').removeClass('error').addClass('loading').html(this.lang.glob_loading).hide().fadeIn(300);
    },
    doError: function(strElement, strError){
        $(strElement).removeClass('success').removeClass('loading').addClass('error').html(strError).hide().fadeIn(300);
    },
    /**
     * as of 27/12/11 i have
     * included my own popup plugin Popupify, therefore doPopup
     * should not be used anymore and is
     * obsolete!
     */
    popup: null,
    popupDiv: "#glob_popup",
    popupDivC: "glob_popup",
    popupDivR: ".popup",
    /**
     * @param {Array} Popup [0] = 1 for instant text in [1], 0 for requesting text via ajax, give url in [2] and request data in [3]
     */
    doPopup: function(popup){
        if (typeof(popup) != 'array' && typeof(popup) != 'object')
            return 0;
        
        /*
        if (this.popup !== null){
            $(this.popupDivR).animate({
                opacity: 0
            }, 300, function(){
                $(this.popupDivR).hide();
                $(this.popupDiv).html('');
                this.popup = null;
            });
        }
        
        var c = this.lang.glob_loading || null;
        if (popup[0] == 1){
            var c = popup[1];
        }else{
            $("#popup-loader").fadeIn(100);
            $.ajax({
                url: popup[2],
                method: "post",
                data: popup[3],
                success:
                    function(response)
                    {
                        var c = response;
                        $(this.popupDiv).html(c);
                    },
                failure:
                    function(error)
                    {
                        return error;
                    },
                complete:
                    function()
                    {
                        $("#popup-loader").fadeOut(100);
                    }
            });
        }
        
        $(this.popupDiv).html(c);
        $(this.popupDivR).css({'opacity': 0}).hide().animate({
            'opacity': 1.0,
            'display': 'block',
            'visibility': 'visible'
        }, 300, function(){
            $(this.popupDivR).show();
        });
        */
        
        var c = popup[0] == 1 ? popup[1] : this.lang.glob_loading || null;
        $("#ppbg").removeCss('height');
        
        if (this.popup !== null)
        {
            $(this.popupDiv).slideToggle(100).html('').fadeIn(100);
            
            if (popup[0] != 1)
            {
                this.doLoadPopup();
                $.ajax({
                    url: popup[2],
                    method: "post",
                    data: popup[3],
                    success:
                        function(response)
                        {
                            $(KS.popupDiv).html(response).slideDown(100);
                            if (intval ($("#ppbg").css('height')) < 500)
                                $("#ppbg").css({height: 'auto'});
                            else
                                $("#ppbg").css({height: '500px'});
                        },
                    failure:
                        function(reponse)
                        {
                            $(KS.popupDiv).html(response).slideDown(100);
                        }
                });
            }
            else
            {
                $(this.popupDiv).html(c).slideDown(100);
                if (intval ($("#ppbg").css('height')) < 500)
                    $("#ppbg").css({height: 'auto'});
                else
                    $("#ppbg").css({height: '500px'});
            }
        }
        else
        {
            this.doDim();
            this.doLoadPopup();
            $(this.popupDivR).show().css({opacity: 0}).animate({opacity: 1.0}, 300, function(){
		$("#ppcl").fadeIn(300);
                if (popup[0] != 1)
                {
                    /*alert ('goes');*/
                    $.ajax({
                        url: popup[2],
                        method: "post",
                        data: popup[3],
                        success:
                            function(response)
                            {
                                $(KS.popupDiv).html(response).show().slideDown(100);
                                if (intval ($("#ppbg").css('height')) < 500)
                                    $("#ppbg").css({height: 'auto'});
                                else
                                    $("#ppbg").css({height: '500px'});
                            },
                        failure:
                            function(reponse)
                            {
                                $(KS.popupDiv).html(response).show().slideDown(100);
                            }
                    });
                }
                else
                {
                    $(this.popupDiv).html(c).slideDown(100);
                    if (intval ($("#ppbg").css('height')) < 500)
                        $("#ppbg").css({height: 'auto'});
                    else
                        $("#ppbg").css({height: '500px'});
                }
            });
        }
        
        $(this.popupDiv).show();
        this.popup = 1;
        return 1;
    },
    doLoadPopup: function(){
        $(this.popupDiv).html('<img src="/themes/knightsshout/img/ajax-loader-3.gif" alt="" />');
    },
    doHidePopup: function(){
	$("#ppbg").removeCss('height');
	$("#ppcl").hide();
        $(this.popupDivR).animate({
            opacity: 0
        }, 300, function(){
            $(KS.popupDivR).hide();
        });
        $(this.popupDiv).html('');
        this.popup = null;
        this.doLighten();
    },
    alignPopup: function(){
        var c = (intval(this.browser.height) - 500) / 2;
        var d = (intval(this.browser.width) - 600) / 2;
        $("#ppbg").css({'margin-top': c, 'margin-left': d});
    },
    doDim: function(){
        $(".dim").fadeIn(300);
    },
    doLighten: function(){
        $(".dim").fadeOut(300);
    },
    pipedAnimation: 0,
    addPipe: function(string, options){
        if (typeof(options) != 'array' && typeof(options) != 'object')
            return 0;
        
        var fstring = null;
        fstring = stripslashes(string).split('\/').join('/');
        
        if (!options.anim)
        {
            $(options.target).append(fstring);
        }
        else
        {
            this.pipedAnimation++;
            fstring = "<span id='jspipeanimation_" + this.pipedAnimation + "' style='display: none;'>" + fstring + "</span>";
            $(options.target).append(fstring);
            $("#jspipeanimation_" + this.pipedAnimation).fadeIn(300);
        }
        
        return 1;
    },
    switchLang: function(strLang){
        this.doPopup(new Array(0, null, '/ajax/translate?to=' + strLang + '&ks_secure_key=' + this.secure_key, null));
	/*
	Popupify.doPopup({type: Popupify.as_ajax, ajax: {
		url: '/ajax/translate',
		method: 'GET',
		data: 'to=' + strLang,
		success: function(rsp){
			location.reload(1);
		}
	}});
	*/
	
        return;
    },
    title_base: document.title,
    updatePageTitle: function(){
	this.notifications_total = this.notifications_friends + this.notifications_other;
	
	if (this.notifications_total == 0)
	{
		set_title(new Array(this.title_base));
	}
	else
	{
		set_title(new Array("+" + this.notifications_total + "   - " + this.title_base));
	}
    },
    hasFriendRequests: function(nCount){
	this.notifications_friends = nCount;
	this.updatePageTitle();
	
	if (this.notifications_friends == 0)
	{
		$("#friend-requests-btn").html('<img src="/themes/knightsshout/img/requests.png" id="friend-requests-img" width="15px" height="15px" alt="" style="border: 1px solid #666;" />');
	}
	else
	{
		$("#friend-requests-btn").html('<img src="/themes/knightsshout/img/requests_new.png" id="friend-requests-img" width="15px" height="15px" alt="" style="border: 1px solid #666;" />');
	}
    },
    hasNotifications: function(nCount){
	this.notifications_other = nCount;
	this.updatePageTitle();
	
	if (this.notifications_other == 0)
	{
		$("#note-requests-btn").html('<img src="/themes/knightsshout/img/notifications.png" id="note-messages-img" width="15px" height="15px" alt="" style="border: 1px solid #666;" />');
	}
	else
	{
		$("#note-requests-btn").html('<img src="/themes/knightsshout/img/notifications_new.png" id="note-messages-img" width="15px" height="15px" alt="" style="border: 1px solid #666;" />');
	}
    },
    enableInput: function(){
	$('input').removeAttr('disabled');
    },
    disableInput: function(){
	$('input').attr('disabled', true);
    }
};

$().ready(function(){
    KS._init ();
    $(window).resize(function(){
        KS.getWindowSize();
        KS.alignPopup();
    });
});