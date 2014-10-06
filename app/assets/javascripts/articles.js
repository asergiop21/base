$(document).ready(function(){
   $(document).on('focus', 'div.articulox, [data-autocomplete-field]', function(){

    var  supplier_id = $(".sup").val();
    console.log(supplier_id);
      var input = $(this);
      input.autocomplete({
         source: function(request, response) {
            $.ajax({
               url: input.data('autocomplete-url'),
               dataType: 'json',
               cache: false,
               data: { q: request.term, supplier_id: supplier_id},
               success: function(data) {
                  response(
                     $.map(data, function(item) {
                        return { label:  item.label, item: item};
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

   $('div.supplier').on('focus', '[data-autocomplete-field]', function(){
      var input = $(this);
      input.autocomplete({
         source: function(request, response) {
            $.ajax({
               url: input.data('autocomplete-url'),
               dataType: 'json', data: { q: request.term },
               success: function(data) {
                  response(
                     $.map(data, function(item) {
                        return { label:  item.name, item: item};
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
   
   
   $('#article_percentaje').on('blur', function(){
      var price = $('#article_price_cost').val();
      var percentaje = $('#article_percentaje').val();
      var price_total = ((parseFloat(price) * parseFloat(percentaje))/100) + parseFloat(price);
      $('#article_price_total').val(price_total.toFixed(2));
      $(this).val(parseFloat($(this).val()).toFixed(2));
   });
});
