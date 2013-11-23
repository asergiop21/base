/*# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
*/
$(document).ready(function(){

 $('form').on('focus', '[data-autocomplete-field-mac]', function(){

var input = $(this); 
input.autocomplete({
  source: function(request, response) {
    $.ajax({
      url: input.data('autocomplete-url'),
      dataType: 'json', data: { q: request.term },
      success: function(data) {
        response(
          $.map(data, function(item) {
            return { label: item.mac , item: item};
          })
        );
      },
    });
  },
  select: function(event, ui) {
input.val(ui.item.label);
$(input.data('autocomplete-for')).val(ui.item.item.id);
  }
}).removeAttr('data-autocomplete-field'); });

$('div.side').on('click', 'option', function(){
    $('form').submit();
});
});
