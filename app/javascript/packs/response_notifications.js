document.addEventListener('turbolinks:load', function() {
  const responseNotificationButtons = document.querySelectorAll('[data-response-id]');
  
  responseNotificationButtons.forEach((responseNotificationButton) => {
      const responseId = responseNotificationButton.getAttribute('data-response-id');

      // リスナーがすでに追加されていないことを確認する
      if (!responseNotificationButton.dataset.listenerAdded) {
          responseNotificationButton.dataset.listenerAdded = 'true';

          responseNotificationButton.addEventListener('click', function(event) {
              // このイベントが親要素に伝播するのを止める
              event.stopPropagation();

              responseNotificationButton.style.display = 'none';
              
              // 各通知のためのフォーム、コメントセクション、ボタン、隠しフィールドを指定する
              const responseForm = document.getElementById(`response-form-${responseId}`);
              const commentSection = document.getElementById(`comment-section-${responseId}`);
              const submitButton = document.getElementById(`submit-btn-${responseId}`);
              const hiddenResponseIdField = document.getElementById(`response-id-field-${responseId}`);

              if (hiddenResponseIdField) {
                  hiddenResponseIdField.value = responseId;
              } else {
                  console.error(`Element with ID response-id-field-${responseId} not found.`);
                  return; // この要素が見つからない場合、以降のコードを実行しない
              }
              
              responseForm.style.display = 'block';
              commentSection.style.display = 'block';
              submitButton.style.display = 'block';

              // 以下の部分で、同じフォームに対してajax:successやajax:errorのイベントリスナーが何度も追加されることを避けるためにチェックが必要です
              if (!responseForm.dataset.listenerAdded) {
                  responseForm.dataset.listenerAdded = 'true';

                  responseForm.addEventListener('ajax:success', function() {
                      alert("返答が成功しました");
                      responseForm.style.display = 'none';
                      commentSection.style.display = 'none';
                      submitButton.style.display = 'none';
                      responseNotificationButton.style.display = 'block';
                  });

                  responseForm.addEventListener('ajax:error', function(event) {
                      const detail = event.detail;
                      const errorMessages = detail[0]['errors'] || [];
                      alert(errorMessages.join(", "));
                      responseNotificationButton.style.display = 'block'; 
                  });
              }
          });
      }
  });
});
