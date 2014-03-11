// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require lazyload.min.js

$(function() {

    $(document).on('click', '#search', function() {
        $('#q').animate({width: 'toggle'},250);
    });

    var slogan = $('#slogan').data('slogan');
    if (slogan != '') {
        $('#slogan').delay(1500).fadeOut(500, function() {
            $(this).text(slogan).fadeIn(500);
        });
    }

    function showAlert() {
        $("#alert").addClass("in");
    }

    window.setTimeout(function () {
        showAlert();
    }, 50);

});

