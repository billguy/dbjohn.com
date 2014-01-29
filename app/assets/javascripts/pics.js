//= require jquery.tokeninput

$(document).on('change', 'form [data-fileupload]', function() {
    var ext, image_container, input, reader;
    input = this;
    image_container = $("#" + input.id).parent().children(".preview");
    if (!image_container.length) {
        image_container = $("#" + input.id).parent().prepend($('<img style="max-width: 100%;"/>').addClass('preview img-polaroid')).find('img.preview');
        image_container.parent().find('img:not(.preview)').hide();
    }
    ext = $("#" + input.id).val().split('.').pop().toLowerCase();
    if (input.files && input.files[0] && $.inArray(ext, ['gif', 'png', 'jpg', 'jpeg', 'bmp']) !== -1) {
        reader = new FileReader();
        reader.onload = function(e) {
            return image_container.attr("src", e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
        return image_container.show();
    } else {
        return image_container.hide();
    }
});