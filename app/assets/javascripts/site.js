$(function() {

    var slogan = $('#slogan').data('slogan');
    if (slogan != '') {
        $('#slogan').fadeOut(500, function() {
            $(this).text(slogan).fadeIn(500);
        });
    }



});