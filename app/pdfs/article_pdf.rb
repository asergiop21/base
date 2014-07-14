class ArticlePdf < Prawn::Document
require 'barby'
require 'barby/barcode/code_39'
require 'barby/outputter/prawn_outputter'

   def initialize(article)
      super(top_margin:70, page_size: "A4")
      @article = article
      barcode 
   end
   def barcode
     1.upto(10) do |i|
        x = 10 
        y = i * 70
        translate(x, y) do
         barcode = Barby::Code39.new @article.barcode
         barcode.annotate_pdf(self)

      end
   end

     1.upto(10) do |i|
        x = 300 
        y = i * 70
        translate(x, y) do
         barcode = Barby::Code39.new @article.barcode
         barcode.annotate_pdf(self)
      end
   end
   end
end
