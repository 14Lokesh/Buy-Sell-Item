$(document).ready(function() {
    $('#flashModal').modal('show');
    setTimeout(function() {
      $('#flashModal').modal('hide');
    }, 2000);
});

$(document).ready(function() {
    $('#mark-read-button').click(function() {
      $('.notification-item').remove();
      $('#notificationCounter').html('0');
    });
});
