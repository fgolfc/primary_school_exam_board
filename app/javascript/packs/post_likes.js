$(document).on('click', '.custom-like-btn', function(event) {
    event.preventDefault(); // Prevent default behavior of the link

    var postId = $(this).data('post-id');
    var isLiked = $(this).text().trim() === 'いいねをキャンセル';

    var method = isLiked ? 'DELETE' : 'POST';
    var url = isLiked ? '/posts/' + postId + '/post_likes/' + $(this).data('like-id') : '/posts/' + postId + '/post_likes';

    $.ajax({
        url: url,
        method: method,
        dataType: 'script',  // Expect server to return executable JavaScript
        success: function() {
            // This is handled by create.js.erb and destroy.js.erb
        },
        error: function(error) {
            console.error(error);
        }
    });
});
