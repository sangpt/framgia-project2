$(document).on('turbolinks:load', function(){
  $(document).ready(function(){
    $('.create-comment').on('submit', function(event) {
      event.preventDefault();
      var params = $(this).serialize();
      var post_id = $(this).children('input#comment_post_id').val();
      $.ajax({
        type: 'POST',
        dateType: 'json',
        url: '/comments/',
        data: params,
        success: function(data){
          $(data.html).appendTo($('#post-comment-' + post_id));
          $('#txt-comment-' + post_id).val('');
          $('#comment-number-' + post_id).text(data.comment_number);
        }
      });
      return false;
    });

    $('body').on('click', '.edit-comment', function() {
      var comment_id = $(this).data('id');
      $.ajax({
        type: 'GET',
        dateType: 'json',
        url: '/comments/'+ comment_id + '/edit/',
        success: function(data){
          var form = $(data.html).attr('class', 'update-comment');
          $('#comment-' + comment_id).replaceWith(form);
        }
      });
    });

    $('body').on('submit', '.update-comment', function(event) {
      event.preventDefault();
      var params = $(this).serialize();
      var comment_id = $(this).data('id');
      $.ajax({
        type: 'PATCH',
        dateType: 'json',
        data: params,
        url: '/comments/'+ comment_id,
        success: function(data){
          $('#edit_comment_' + comment_id).replaceWith(data.html);
        }
      });
      return false;
    });

    $('body').on('click','.delete-comment', function() {
      var comment_id = $(this).data('id');
      var post_id = $(this).attr('post-id');
      $.ajax({
        type: 'DELETE',
        dateType: 'json',
        url: '/comments/'+ comment_id,
        data: {id: comment_id},
        success: function(data){
          $('#comment-' + comment_id).fadeOut();
          $('#comment-number-' + post_id).text(data.comment_number);
        }
      });
    });
  })
});
