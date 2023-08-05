$(document).on('click', '.like-button', function() {
  var responseId = $(this).data('response-id');
  $.ajax({
    url: '/responses/' + responseId + '/response_likes',
    method: 'POST',
    dataType: 'json',
    success: function(data) {
      $('#like-count-' + responseId).text(data.like_count);
    },
    error: function(error) {
      console.error(error);
    }
  });
});

$(document).on('click', '.unlike-button', function() {
  var responseId = $(this).data('response-id');
  $.ajax({
    url: '/responses/' + responseId + '/response_likes',
    method: 'DELETE',
    dataType: 'json',
    success: function(data) {
      $('#like-count-' + responseId).text(data.like_count);
    },
    error: function(error) {
      console.error(error);
    }
  });
});
