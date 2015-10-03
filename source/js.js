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

    setup_chat_button();
    $(window).resize(setup_chat_button);
});

function setup_chat_button() {
    var el = $('#chat');
    if ( ! el.length ) { return; }

    var cont = $('.bg > .container');
    el.css({
        left: cont.offset().left + cont.innerWidth() - el.outerWidth() - 15
    });

    // el.css({opacity: 1});
    setTimeout(function(){el.animate({bottom: '-10px'});}, 1000);
}