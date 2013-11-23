/*$(document).ready(function(){
        $('.solved').click(function(){ 
            $('form').submit();
            return false;
        });
})*/
$(document).on('click', 'a[data-cambiar-estado]', function() {
  $('#ticket_status').val($(this).data('cambiar-estado'));
  $('form').submit();
});

$(document).on('click', 'a[data-pasar]', function() {
  $('#ticket_role_id').val($(this).data('pasar'));
  $('form').submit();
});
