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
                const centerContainer = document.querySelector(`#notification-form-${postId}`).closest('.center-container');
                
                const notificationForm = document.getElementById(`notification-form-${postId}`);
                const commentSection = document.getElementById(`comment-section-${postId}`);
                const submitButton = document.getElementById(`submit-btn-${postId}`);
                const hiddenPostIdField = document.getElementById(`post-id-field-${postId}`);

                if (hiddenPostIdField) {
                    hiddenPostIdField.value = postId;
                } else {
                    console.error(`Element with ID post-id-field-${postId} not found.`);
                    return;
                }

                if (!notificationForm.dataset.listenerAdded) {
                    notificationForm.dataset.listenerAdded = 'true';
                    
                    notificationForm.addEventListener('ajax:success', function() {
                        alert("通知が成功しました");
                        hideElement(notificationForm);
                        hideElement(commentSection);
                        hideElement(submitButton);
                        hideElement(notifyAdminButton); // 通知成功時にボタンを非表示にする
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
                }

                showElement(notificationForm);
                showElement(commentSection);
                showElement(submitButton);
                hideElement(notifyAdminButton); // ボタンをクリックしたときにボタン自体を非表示にする

                if (centerContainer) {
                    centerContainer.style.height = 'auto';
                }
            });
        }
    });
});