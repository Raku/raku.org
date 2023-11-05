jQuery(function ($) {
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
});
