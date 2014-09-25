class GroupLabelPdf < Prawn::Document
  require 'barby'
  require 'barby/barcode/code_39'
  require 'barby/outputter/prawn_outputter'

  def initialize(group_label)
    super(top_margin:70, page_size: "A4")
    @group_label = group_label
    labels 
  end

  def labels
    x_aux = 10
    y_aux = 0
    x = 0
    y = 0 
    a = 1
    y_total = 0
    @group_label.each do |g|
        if (y >= 630 )
          x_aux = 300
          y_aux = 0  
        end
      1.upto(g.quantity) do |a|
        x = x_aux 
        y = (a * 70) + y_aux
      p y_total = y_total +  70  
        
        barcode_text(g.article.barcode, g.article.name, x , y)
        
        if (a == g.quantity)
          y_aux = y
        end
      end
    end
  end

  def barcode_text(barcode, name,x , y) 

    font_size(8)

    draw_text barcode + " - " + name, :at=> [x,y - 10 ]
    translate(x, y) do
      barcode = Barby::Code39.new barcode
      barcode.annotate_pdf(self)
    end
  end 
end
