$(document).on('turbolinks:load', function(){
  $(document).ready(function(){
    $('body').on('submit','.new_relationship', function(e) {
      e.preventDefault();
      var followed_id = $(this).find('#followed_id').val();
      $.ajax({
        type: 'POST',
        dateType: 'json',
        url: '/relationships/',
        data: {followed_id: followed_id},
        success: function(data){
          $('#follow_form').html(data.html);
          $('#followers').text(data.followers);
        }
      });
    });

    $('body').on('submit','.edit_relationship', function(e) {
      e.preventDefault();
      var followed_id = $(this).data('id');
      var relationship_id ;
      $.ajax({
        type: 'DELETE',
        dateType: 'json',
        data: {followed_id: followed_id},
        url: '/relationships/' + followed_id,
        success: function(data){
          $('#follow_form').html(data.html);
          $('#followers').text(data.followers);
        }
      });
    });
  })
});


