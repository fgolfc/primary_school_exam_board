document.getElementById("notify-btn").addEventListener("click", function() {
  document.getElementById("comment-section").style.display = "block";
});

document.getElementById("submit-btn").addEventListener("click", function() {
  const comment = document.getElementById("comment").value;
  // 通知をサーバーに送信
  sendNotification(comment);
});

function sendNotification(comment) {
  // Ajaxを使ってサーバーに通知を送信
  fetch("/path/to/your/endpoint", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content
    },
    body: JSON.stringify({ comment: comment })
  }).then(response => response.json())
    .then(data => alert(data.message));
}
