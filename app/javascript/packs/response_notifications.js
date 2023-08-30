document.addEventListener('turbolinks:load', function() {
  const responseNotifyAdminButtons = document.querySelectorAll('[data-response-id]');

  function hideElement(el) {
      el.style.opacity = '0';
      el.style.visibility = 'hidden';
  }

  function showElement(el) {
      el.style.opacity = '1';
      el.style.visibility = 'visible';
  }

  responseNotifyAdminButtons.forEach((notifyAdminButton) => {
      const responseId = notifyAdminButton.getAttribute('data-response-id');

      if (!notifyAdminButton.dataset.listenerAdded) {
          notifyAdminButton.dataset.listenerAdded = 'true'; 

          notifyAdminButton.addEventListener('click', function(event) {
              hideElement(notifyAdminButton);
              
              const responseNotificationForm = document.getElementById(`notification-form-${responseId}`);
              const commentSection = document.getElementById(`comment-section-${responseId}`);
              const submitButton = document.getElementById(`submit-btn-${responseId}`);
              const hiddenResponseIdField = document.getElementById(`response-id-field-${responseId}`);
              const centerContainer = document.querySelector('.center-container');

              if (hiddenResponseIdField) {
                  hiddenResponseIdField.value = responseId;
              } else {
                  console.error(`Element with ID response-id-field-${responseId} not found.`);
                  return;
              }
              
              showElement(responseNotificationForm);
              showElement(commentSection);
              showElement(submitButton);

              if (centerContainer) {
                  centerContainer.style.height = 'auto';
              }

              if (!responseNotificationForm.dataset.listenerAdded) {
                  responseNotificationForm.dataset.listenerAdded = 'true';

                  responseNotificationForm.addEventListener('ajax:success', function() {
                      alert("通知が成功しました");
                      hideElement(responseNotificationForm);
                      hideElement(commentSection);
                      hideElement(submitButton);
                      showElement(notifyAdminButton);

                      if (centerContainer) {
                          centerContainer.style.height = '0';
                      }
                  });

                  responseNotificationForm.addEventListener('ajax:error', function(event) {
                      const detail = event.detail;
                      const errorMessages = detail[0]['errors'] || [];
                      alert(errorMessages.join(", "));
                      showElement(notifyAdminButton);
                  });
              }
          });
      }
  });
});
