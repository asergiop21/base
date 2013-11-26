class InvoicePdf < Prawn::Document

  def initialize(invoice)
          super(top_margin: 70)
          @invoice = invoice
          text "Cliente: " + @invoice.customer.name + ", " + @invoice.customer.lastname
          text "Fecha: " + I18n.l(@invoice.created_at , format: :short)
          text "Presupuesto \##{@invoice.id}"
          line_items

  end


  def line_items
          move_down 20
          table line_item_rows
  end

  def line_item_rows
          
          [["Producto", "Cantidad"]] +
                  @invoice.orders.map do |item|
                  [item.name, item.quantity]
          end
  end

end
