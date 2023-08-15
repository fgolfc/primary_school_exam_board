$(document).ready(function() {
  $('#notify-admin-btn').click(function() {
    $('#comment-section').show();
  });

  $('#submit-btn').click(function() {
    var comment = $('#comment').val();
    // ここで通知情報をバックエンドに送信するためのAjaxリクエストを書く
  });
});
