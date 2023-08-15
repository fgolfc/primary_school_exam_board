document.addEventListener('turbolinks:load', function() {
  const notifyAdminButton = document.getElementById('notify-admin-btn');
  const notificationForm = document.getElementById('notification-form');
  const commentSection = document.getElementById('comment-section');
  const submitButton = document.getElementById('submit-btn');

  if (notifyAdminButton) { // Elementの存在確認
      notifyAdminButton.addEventListener('click', function() {
          notifyAdminButton.style.display = 'none';
          notificationForm.style.display = 'block';
          commentSection.style.display = 'block';
          submitButton.style.display = 'block';
      });
  }
});
