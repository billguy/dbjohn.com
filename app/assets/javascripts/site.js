$(function() {

    var slogan = $('#slogan').data('slogan');
    if (slogan != '') {
        $('#slogan').delay(1500).fadeOut(500, function() {
            $(this).text(slogan).fadeIn(500);
        });
    }



});