$('#micropost_image'),bind('change', function() {
  var size_in_megabytes = this.files[0].size/1024/1024;
  alert("aaa")
  if (size_in_megabytes > 0) {
    alert(I18n.t("maximum_file_size"));
  }
});
