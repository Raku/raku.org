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
});