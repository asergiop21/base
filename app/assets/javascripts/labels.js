$(document).ready(function(){

  $('div.line3').on('focus', '[data-autocomplete-for]', function(){
    var input = $(this);
    input.autocomplete({
      source: function(request, response) {
        $.ajax({
          url: input.data('autocomplete-url'),
          dataType: 'json', data: { q: request.term },
          success: function(data) {
            response(
              $.map(data, function(item) {
                return {label:item.label, item: item};
              })
              );
          },
        });
      },
      minLength: 3,
      select: function(event, ui) {
        input.val(ui.item.label);
        var field = this.id;
        var id = field.split("_");
        var field_article_id = '#group_label_labels_attributes_' + id[4] + '_article_id';
        $(field_article_id).val(ui.item.item.id);
      }
    
    }).removeAttr('data-autocomplete-field');
  });
  });
