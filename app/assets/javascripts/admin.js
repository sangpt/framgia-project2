$(document).on('turbolinks:load', function(){
  $(document).ready(function(){
   $('body').on('change', '#time_choice', function() {
    var time = $(this).val();
    $.ajax({
      type: 'GET',
      dateType: 'json',
      url: '/load_statistics/',
      data: {choice: time},
      success: function(data){
        $('#total_users').text(data.count.users);
        $('#total_posts').text(data.count.posts);
        $('#total_comments').text(data.count.comments);
        $('#total_likes').text(data.count.likes);
        $('#total_tags').text(data.count.tags);
      }
    });
  });

 })
});
