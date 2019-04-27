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
    update_pre_tag_left_top_border_radius();
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
    })
    .fail(function() {
        el.append('<li><i>Failed to fetch recent blogs</i></li>');
    });
}

// This function updates first <pre> tag's left-top border radius
// responsively when the different tab is clicked
function update_pre_tag_left_top_border_radius () {
    $(document).ready(function() {
        $('.tab-content') > $('pre').first().css('border-radius', '0px 4px 4px');
        $('ul.nav-tabs li').click(function(e) {
            var firstPreEl = $('.tab-content') > $('pre').first();
            if ($(this).index() === 0) {
                firstPreEl.css('border-radius', '0px 4px 4px');
            } else {
                firstPreEl.css('border-radius', '4px');
            }
        });
    });
}
