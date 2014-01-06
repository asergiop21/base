class InvoicePdf < Prawn::Document

  def initialize(invoice, user)
          super(top_margin: 70)
          @invoice = invoice
          @user = user
          text "Cliente: " + @invoice.customer.name + ", " + @invoice.customer.lastname
          text "Fecha: " + I18n.l(@invoice.created_at , format: :short)
          text "Presupuesto \##{@invoice.id}"
            line_items
          print_user
  end


  def line_items
          move_down 20
          
          if @invoice.current_account == false
          table line_item_rows

          else

          table line_item_rows_without_price

          end
  end



  def line_item_rows
          [["Producto", "Cantidad", "Price"]] +
                  @invoice.orders.map do |item|
                  [item.name, item.quantity, item.price_total]
          end
  end


  def line_item_rows_without_price
          [["Producto", "Cantidad"]] +
                  @invoice.orders.map do |item|
                  [item.name, item.quantity]
          end
  end

  
  def print_user

          text "Usuario: " + @user.name
  end



end
