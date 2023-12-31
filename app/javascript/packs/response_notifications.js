document.addEventListener('turbolinks:load', function() {
    // const responseNotifyAdminButtons = document.querySelectorAll('[data-response-id]');
    const responseNotifyAdminButtons = document.querySelectorAll('.custom-notify-response-btn');

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
                
                // #js-ResponseFormArea
                // document.getElementById("js-ResponseFormArea");

                const centerContainer = document.getElementById(`js-ResponseFormArea-${responseId}`);

                const responseNotificationForm = centerContainer.querySelector(`#notification-form-${responseId}`)
                const commentSection = centerContainer.querySelector(`#comment-section-${responseId}`);
                const submitButton = centerContainer.querySelector(`#submit-btn-${responseId}`);
                const hiddenResponseIdField = centerContainer.querySelector(`#response-id-field-${responseId}`);

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
                    centerContainer.style.height = 'auto'; // Set the container height to fit the content
                }

                responseNotificationForm.addEventListener('ajax:success', function() {
                    alert("通知が成功しました");
                    hideElement(responseNotificationForm);
                    hideElement(commentSection);
                    hideElement(submitButton);
                    showElement(notifyAdminButton);

                    if (centerContainer) {
                        centerContainer.style.height = '0'; // Hide the container by setting its height to 0
                    }
                });

                responseNotificationForm.addEventListener('ajax:error', function(event) {
                    const detail = event.detail;
                    const errorMessages = detail[0]['errors'] || [];
                    alert(errorMessages.join(", "));
                    showElement(notifyAdminButton);
                });
            });
        }
    });
});
