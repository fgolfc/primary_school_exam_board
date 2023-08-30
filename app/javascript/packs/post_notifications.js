document.addEventListener('turbolinks:load', function() {
    const notifyAdminButtons = document.querySelectorAll('[data-post-id]');
    
    function hideElement(el) {
        el.style.opacity = '0';
        el.style.visibility = 'hidden';
    }

    function showElement(el) {
        el.style.opacity = '1';
        el.style.visibility = 'visible';
    }

    notifyAdminButtons.forEach((notifyAdminButton) => {
        const postId = notifyAdminButton.getAttribute('data-post-id');

        if (!notifyAdminButton.dataset.listenerAdded) {
            notifyAdminButton.dataset.listenerAdded = 'true'; 

            notifyAdminButton.addEventListener('click', function(event) {
                hideElement(notifyAdminButton);
                
                const notificationForm = document.getElementById(`notification-form-${postId}`);
                const commentSection = document.getElementById(`comment-section-${postId}`);
                const submitButton = document.getElementById(`submit-btn-${postId}`);
                const hiddenPostIdField = document.getElementById(`post-id-field-${postId}`);
                const centerContainer = document.querySelector('.center-container');

                if (hiddenPostIdField) {
                    hiddenPostIdField.value = postId;
                } else {
                    console.error(`Element with ID post-id-field-${postId} not found.`);
                    return;
                }
                if (!notificationForm || !commentSection || !submitButton) {
                    console.error("Some elements are missing!");
                    return;
                }
                showElement(notificationForm);
                showElement(commentSection);
                showElement(submitButton);

                // ここを追加: center-containerの高さをautoに設定
                if (centerContainer) {
                    centerContainer.style.height = 'auto';
                }

                notificationForm.addEventListener('ajax:success', function() {
                    alert("通知が成功しました");
                    hideElement(notificationForm);
                    hideElement(commentSection);
                    hideElement(submitButton);
                    showElement(notifyAdminButton);

                    // ここを追加: center-containerの高さを0に設定
                    if (centerContainer) {
                        centerContainer.style.height = '0';
                    }
                });

                notificationForm.addEventListener('ajax:error', function(event) {
                    const detail = event.detail;
                    const errorMessages = detail[0]['errors'] || [];
                    alert(errorMessages.join(", "));
                    showElement(notifyAdminButton);
                });
            });
        }
    });
});
