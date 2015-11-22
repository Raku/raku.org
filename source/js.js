jQuery(function ($) {
    $.fn.sameHeight = function() {
        var max = 0;
        $(this).each(function(){
            var h = $(this).outerHeight();
            if ( h > max ) { max = h }
        });

        $(this).css('min-height', max + 'px');
    }

    $('.home section:eq(0) .panel-body, .home section:eq(1) .panel-body').sameHeight();
    $('footer ul').sameHeight();
    $('.equal-panels .panel-body').sameHeight();

    if ( ! $('.bg').length ) { $('body').css({background: '#fff'}) }

    setup_recent_blog_posts();
});

function setup_recent_blog_posts () {
    var el = $('#recent_blog_posts');
    if ( ! el.length ) { return; }


    $.jQRSS(
        { count: 3, rss: 'http://pl6anet.org/atom.xml' },
        function(feed) {
            if ( ! feed ) { return false; }
            $(feed.entries).each(function(){
                el.append(
                    '<li><a href="'
                    + this.link + '">' + this.title + '</a></li>'
                );
            });

            $('#features_row h3').sameHeight();
            $('#features_row .panel-body').sameHeight();
        }
    );
}

/** RSS Reader **/
(function($) {
    if (!$.jQRSS) {
        $.extend({
            jQRSS: function(rss, options, func) {
                if (arguments.length <= 0) return false;

                var str, obj, fun;
                for (i=0;i<arguments.length;i++) {
                    switch(typeof arguments[i]) {
                        case "string":
                            str = arguments[i];
                            break;
                        case "object":
                            obj = arguments[i];
                            break;
                        case "function":
                            fun = arguments[i];
                            break;
                    }
                }

                if (str == null || str == "") {
                    if (!obj['rss']) return false;
                    if (obj.rss == null || obj.rss == "") return false;
                }

                var o = $.extend(true, {}, $.jQRSS.defaults);

                if (typeof obj == "object") {
                    if ($.jQRSS.methods.getObjLength(obj) > 0) {
                        o = $.extend(true, o, obj);
                    }
                }

                if (str != "" && !o.rss) o.rss = str;
                o.rss = escape(o.rss);

                var gURL = $.jQRSS.props.gURL
                    + $.jQRSS.props.type
                    + "?v=" + $.jQRSS.props.ver
                    + "&q=" + o.rss
                    + "&callback=" + $.jQRSS.props.callback;

                var ajaxData = {
                        num: o.count,
                        output: o.output
                    };

                if (o.historical) ajaxData.scoring = $.jQRSS.props.scoring;
                if (o.userip != null) ajaxData.scoring = o.userip;

                $.ajax({
                    url: gURL,
                    beforeSend: function (jqXHR, settings) {
                        try {
                            console.log(new Array(30).join('-'), "REQUESTING RSS XML", new Array(30).join('-'));
                            console.log({ ajaxData: ajaxData, ajaxRequest: settings.url, jqXHR: jqXHR, settings: settings, options: o });
                            console.log(new Array(80).join('-'));
                        } catch(err) {  }
                    },
                    dataType: o.output != "xml" ? "json" : "xml",
                    data: ajaxData,
                    type: "GET",
                    xhrFields: { withCredentials: true },
                    error: function (jqXHR, textStatus, errorThrown) { return new Array("ERROR", { jqXHR: jqXHR, textStatus: textStatus, errorThrown: errorThrown } ); },
                    success: function (data, textStatus, jqXHR) {
                        var f = data['responseData'] ? data.responseData['feed'] ? data.responseData.feed : null : null,
                            e = data['responseData'] ? data.responseData['feed'] ? data.responseData.feed['entries'] ? data.responseData.feed.entries : null : null : null
                        try {
                            console.log(new Array(30).join('-'), "SUCCESS", new Array(30).join('-'));
                            console.log({ data: data, textStatus: textStatus, jqXHR: jqXHR, feed: f, entries: e });
                            console.log(new Array(68).join('-'));
                        } catch(err) {  }

                        if (fun) {
                            return fun.call(this, data['responseData'] ? data.responseData['feed'] ? data.responseData.feed : data.responseData : null);
                        }
                        else {
                            return { data: data, textStatus: textStatus, jqXHR: jqXHR, feed: f, entries: e };
                        }
                    }
                });
            }
        });
        $.jQRSS.props = {
            callback: "?",
            gURL: "http://ajax.googleapis.com/ajax/services/feed/",
            scoring: "h",
            type: "load",
            ver: "1.0"
        };
        $.jQRSS.methods = {
            getObjLength: function(obj) {
                if (typeof obj != "object") return -1;
                var objLength = 0;
                $.each(obj, function(k, v) { objLength++; })
                return objLength;
            }
        };
        $.jQRSS.defaults = {
            count: "10", // max 100, -1 defaults 100
            historical: false,
            output: "json", // json, json_xml, xml
            rss: null,
            userip: null
        };
    }
})(jQuery);
