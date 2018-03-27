$(function(){
    setup_carousels();
});

function setup_carousels() {
    $('.carousel').carousel();

    var max_height = 0;
    $('.carousel .carousel-item').each(function(){
        var h = $(this).height();
        if (h > max_height) max_height = h;
    });
    $('.carousel .carousel-item').css({height: max_height + 'px'});
}
