document.addEventListener('turbolinks:load', function() {
    const notifyAdminButtons = document.querySelectorAll('[data-post-id]');
    
    notifyAdminButtons.forEach((notifyAdminButton) => {
        const postId = notifyAdminButton.getAttribute('data-post-id');

        if (!notifyAdminButton.dataset.listenerAdded) {
            notifyAdminButton.dataset.listenerAdded = 'true'; 

            notifyAdminButton.addEventListener('click', function(event) {
                // このイベントが親要素に伝播するのを止める
                event.stopPropagation();

                notifyAdminButton.style.display = 'none';
                
                // 各投稿のためのフォーム、コメントセクション、ボタン、隠しフィールドを指定する
                const notificationForm = document.getElementById(`notification-form-${postId}`);
                const commentSection = document.getElementById(`comment-section-${postId}`);
                const submitButton = document.getElementById(`submit-btn-${postId}`);
                const hiddenPostIdField = document.getElementById(`post-id-field-${postId}`);

                if (hiddenPostIdField) {
                    hiddenPostIdField.value = postId;
                } else {
                    console.error(`Element with ID post-id-field-${postId} not found.`);
                    return; // この要素が見つからない場合、以降のコードを実行しない
                }
                
                notificationForm.style.display = 'block';
                commentSection.style.display = 'block';
                submitButton.style.display = 'block';

                notificationForm.addEventListener('ajax:success', function() {
                    alert("通知が成功しました");
                    notificationForm.style.display = 'none';
                    commentSection.style.display = 'none';
                    submitButton.style.display = 'none';
                    notifyAdminButton.style.display = 'block';
                });

                notificationForm.addEventListener('ajax:error', function(event) {
                    const detail = event.detail;
                    const errorMessages = detail[0]['errors'] || [];
                    alert(errorMessages.join(", "));
                    notifyAdminButton.style.display = 'block'; // エラー時にボタンを再表示
                });
            });
        }
    });
});
