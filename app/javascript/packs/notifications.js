document.addEventListener('turbolinks:load', function() {
  const notifyAdminButton = document.getElementById('notify-admin-btn');
  const notificationForm = document.getElementById('notification-form');
  const commentSection = document.getElementById('comment-section');
  const submitButton = document.getElementById('submit-btn');
  const postIdField = document.getElementById('post-id-field');

  if (notifyAdminButton) {
      notifyAdminButton.addEventListener('click', function() {
          notifyAdminButton.style.display = 'none';
          notificationForm.style.display = 'block';
          commentSection.style.display = 'block';
          submitButton.style.display = 'block';
          postIdField.value = someValue; // TODO: この部分を現在のpostのIDで適切に更新してください。
      });
  }

  if (notificationForm) {
      notificationForm.addEventListener('ajax:success', function() {
          alert("通知が成功しました");
          // 通知フォームやボタンの状態をリセットする
          notifyAdminButton.style.display = 'block';
          notificationForm.style.display = 'none';
          commentSection.style.display = 'none';
          submitButton.style.display = 'none';
      });

      notificationForm.addEventListener('ajax:error', function(event) {
          const detail = event.detail;
          const errorMessages = detail[0]['errors'] || [];
          alert(errorMessages.join(", "));
      });
  }
});
