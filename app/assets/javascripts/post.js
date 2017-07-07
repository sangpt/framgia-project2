$(document).on('turbolinks:load', function(){
  $(document).ready(function(){
    $('body').on('click','.delete-post', function() {
      var post_id = $(this).attr('id');
      console.log(post_id);
      $.ajax({
        type: 'DELETE',
        dateType: 'json',
        url: '/posts/'+ post_id,
        data: {id: post_id},
        success: function(data){
          $('#post-' + post_id).hide();
        }
      });
    });

    $('body').on('click', '.edit-post', function() {
      var post_id = $(this).attr('id');
      $.ajax({
        type: 'GET',
        dateType: 'json',
        url: '/posts/'+ post_id + '/edit/',
        success: function(data){
          $('body').prepend(data.html);
          $('#myModal').modal();
        }
      });
    });

    $('#create-post').on('click', function(event) {
      event.preventDefault();
      var post_id = $(this).attr('id');
      var post_title = $('#post_title').val();
      var post_content = $('#post_content').val();
      var post_picture = $('#post_picture').val();

      var params = $('#new_post').serialize();
      $.ajax({
        type: 'POST',
        dateType: 'json',
        url: '/posts/',
        data: params,
        success: function(data){
          $(data.html).prependTo($('#posts'));
        }
      });
      return false;
    });

    $('body').on('click', '#update-post', function(event) {
      event.preventDefault();
      var post_id = $(this).parent().data('id');
      var params = $(this).parent().serialize();
      console.log(params);
      $.ajax({
        type: 'PATCH',
        dateType: 'json',
        data: params,
        url: '/posts/'+ post_id,
        success: function(data){
          $('#post-' + post_id).replaceWith(data.html);
          $('#myModal').modal('hide');
        }
      });
      return false;
    });

    $('.show-comment').click(function() {
      $(this).parents('li.post').find('.comment-area').toggle();
    });

  })
});


