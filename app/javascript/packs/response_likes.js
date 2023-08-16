$(document).on('click', '.custom-like-btn', function(event) {
    event.preventDefault(); // Prevent default behavior of the link

    var responseId = $(this).data('response-id');
    var isLiked = $(this).text().trim() === 'いいねをキャンセル';

    var method = isLiked ? 'DELETE' : 'POST';
    var url = isLiked ? '/responses/' + responseId + '/response_likes/' + $(this).data('like-id') : '/responses/' + responseId + '/response_likes';

    $.ajax({
        url: url,
        method: method,
        dataType: 'script',  // Expect server to return executable JavaScript
        success: function() {
            // This is handled by create.js.erb and destroy.js.erb for response_likes
        },
        error: function(error) {
            console.error(error);
        }
    });
});