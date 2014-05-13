//= require jquery.tokeninput
//= require tinycolor-0.9.15.min.js
//= require pick-a-color-1.2.3.min.js

$(function(){
    var options = {theme: 'facebook', preventDuplicates: true};

    if (typeof tags !== "undefined" && tags.length > 0){
        var tv = [];
        $.each(tags.split(","), function(index, value){
            tv.push({id: value, name: value});
        });
        options['prePopulate'] = tv;
    }
    $(".tag_list").tokenInput("/tags", options);

    $(".pick-a-color").pickAColor();
});