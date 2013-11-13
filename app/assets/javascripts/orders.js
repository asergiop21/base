$(document).ready(function(){

        $(document).on('click','.remove_fields_orders', function(event){
                $(this).prev('input[type=hidden]').val('1')
                var price_remove = $(this).closest('fieldset').find('input.price_subtotal').val();
        var price_total = $('#invoice_price_total').val();
        if (price_total > 0)
        {
                var valor = parseFloat(price_total) - parseFloat(price_remove);
        }
        price_total = $('#invoice_price_total').val(valor);
        $(this).closest('fieldset').hide()
                event.preventDefault();
        });

        $('div.section ').on('focus', '[data-autocomplete-for]', function(){
                var input = $(this);
                input.autocomplete({
                        source: function(request, response) {
                                $.ajax({
                                        url: input.data('autocomplete-url'),
                                        dataType: 'json', data: { q: request.term },
                                        success: function(data) {
                                                response(
                                                        $.map(data, function(item) {
                                                                return { label: item.name , item: item};
                                                        })
                                                        );
                                        },
                                });
                        },

                        select: function(event, ui) {
                                input.val(ui.item.label);
                                // alert (ui.item.item.price_total);
                                var field = this.id;
                                var id = field.split("_");
                                var field_article_id = '#invoice_orders_attributes_' + id[3] + '_articles_id';
                                var field_unit_price = '#invoice_orders_attributes_' + id[3] + '_unit_price';
                                var quantity_stock = '#invoice_orders_attributes_' + id[3] + '_quantity_stock';


                                $(field_article_id).val(ui.item.item.id);
                                $(field_unit_price).val(ui.item.item.price_total);
                                $(quantity_stock).val(ui.item.item.quantity);
                        }
                }).removeAttr('data-autocomplete-field'); });

        $(document).on('blur','.quantity', function(event){

                var field = this.id;
                var input = $(this).val();
                if (input == 0)
        {
                $(this).val(0);
                input = 0;
        }

        var id = field.split("_");
        var price_subtotal = '#invoice_orders_attributes_' + id[3] + '_price_total';
        var price = $('#invoice_orders_attributes_' + id[3] + '_unit_price').val();
        var quantity_stock = $('#invoice_orders_attributes_' + id[3] + '_quantity_stock').val();
        var price_x_quantity = parseFloat(input) * parseFloat(price);

        $(price_subtotal).val(price_x_quantity);

        var prr = $('#invoice_price_total').val();
        if (prr == 0)
        {
                prr = 0.00;
        }
        if ( quantity_stock < input)
        {
            alert('stock demas');
        }else
        {
          alert('stock menos');
        }



        suma_una = parseFloat(prr) + parseFloat(price_x_quantity) ;
        $('#invoice_price_total').val(suma_una);

        });


        $(document).on('keydown', 'input, select, textarea', function(e) {
                var a = this.id 
                var self = $(this),
                form = self.parents('form:eq(0)'),
                focusable,
                next;

        if (e.keyCode == 13) {


                focusable = form.find('input,a,textarea').filter(':visible').not(".remove_fields_orders");
                next = focusable.eq(focusable.index(this)+1);
                if (next.length) {
                        next.focus();
                        next.select();
                } else {
                        form.submit();
                }
                return false;
        }
        });


})
