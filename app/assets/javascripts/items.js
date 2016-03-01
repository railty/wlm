$(function() {
  console.log( "ready!" );

  $('input[type=radio][name=radioPrimary]').change(function() {
    $('.photo_type').val('');
    $(this).parent().next().val('Primary');
  });
});

function fileSelected(me) {
  $("#upload-file-info").html($(me).val().replace(/^.*[\\\/]/, ""));
  var reader = new FileReader();
  reader.onload = function (e) {
    $("#imgPreview").attr("src", e.target.result);
  };
  reader.readAsDataURL(me.files[0]);
};
