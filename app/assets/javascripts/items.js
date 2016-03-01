$(function() {
    console.log( "ready!" );
});

function fileSelected(me) {
    $("#upload-file-info").html($(me).val().replace(/^.*[\\\/]/, ""));
    var reader = new FileReader();

    reader.onload = function (e) {
      $("#imgPreview").attr("src", e.target.result);
    };

    // read the image file as a data URL.
    reader.readAsDataURL(me.files[0]);
};
