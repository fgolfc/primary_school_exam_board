document.addEventListener('turbolinks:load', function() {
  const responseNotifyAdminButtons = document.querySelectorAll('[data-response-id]');

  responseNotifyAdminButtons.forEach((notifyAdminButton) => {
      const responseId = notifyAdminButton.getAttribute('data-response-id');

      // ここでresponseのpost_idを取得します
      const hiddenPostIdField = document.getElementById(`post-id-field-${responseId}`);
      const postIdValue = hiddenPostIdField ? hiddenPostIdField.value : null;
      
      if (!notifyAdminButton.dataset.listenerAdded) {
          notifyAdminButton.dataset.listenerAdded = 'true'; 

          notifyAdminButton.addEventListener('click', function(event) {
              notifyAdminButton.style.display = 'none';

              const responseNotificationForm = document.getElementById(`notification-form-${responseId}`);
              const commentSection = document.getElementById(`comment-section-${responseId}`);
              const submitButton = document.getElementById(`submit-btn-${responseId}`);
              const hiddenResponseIdField = document.getElementById(`response-id-field-${responseId}`);

              if (hiddenResponseIdField && postIdValue) {
                  hiddenResponseIdField.value = responseId;
                  // ここでpost_idのhidden fieldの値をセットします
                  hiddenPostIdField.value = postIdValue;
              } else {
                  console.error(`Element with ID response-id-field-${responseId} or post-id-field-${responseId} not found.`);
                  return;
              }

              responseNotificationForm.style.display = 'block';
              commentSection.style.display = 'block';
              submitButton.style.display = 'block';

              if (!responseNotificationForm.dataset.listenerAdded) {
                  responseNotificationForm.dataset.listenerAdded = 'true';

                  responseNotificationForm.addEventListener('ajax:success', function() {
                      alert("通知が成功しました");
                      responseNotificationForm.style.display = 'none';
                      commentSection.style.display = 'none';
                      submitButton.style.display = 'none';
                      notifyAdminButton.style.display = 'block';
                  });

                  responseNotificationForm.addEventListener('ajax:error', function(event) {
                      const detail = event.detail;
                      const errorMessages = detail[0]['errors'] || [];
                      alert(errorMessages.join(", "));
                      notifyAdminButton.style.display = 'block';
                  });
              }
          });
      }
  });
});
