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


    $.ajax('recent-blog-posts.json')
    .done(function(feed) {
        $(feed).each(function(){
            el.append(
                '<li><a href="'
                + this.link + '">' + this.title + '</a></li>'
            );
        });

        $('#features_row h3').sameHeight();
        $('#features_row .panel-body').sameHeight();
    })
    .fail(function() {
        el.append('<li><i>Failed to fetch recent blogs</i></li>');
    });
}
