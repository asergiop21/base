class InvoicesController < ApplicationController
   # GET /invoices
   # GET /invoices.json

   before_filter :authenticate_user!, :except => [:some_action_without_auth]
   before_filter :load_customers
   def index

      @invoices = @customer.invoices.all
      @articles = Article.con_nombre_barcode(params[:q]) if params[:q].present?
      @payments = 0
      @invoices.each do |e|
         if e.cancelar_invoice == false
            @payments  += Payment.where('invoice_id = ?', e.id).sum(&:amount)
         end
      end

      @amount = @customer.invoices.total_amount 
      @total = @payments - @amount

      respond_to do |format|

         format.html # index.html.erb
         format.json { render json: @invoices }
      end

   end

   # GET /invoices/1
   # GET /invoices/1.json
   def show
      @invoice = @customer.invoices.find(params[:id])
      respond_to do |format|
         format.html # show.html.erb
         ## format.json { render json: @invoice }

         format.pdf do
            pdf = InvoicePdf.new(@invoice , current_user)
            send_data pdf.render, filename: "order_#{@invoice.id}.pdf",
               type: "application/pdf",
               disposition: "inline" 
         end
      end
   end

   # GET /invoices/new
   # GET /invoices/new.json
   def new

      @invoice = @customer.invoices.new
      1.times {@invoice.orders.build}
      1.times {@invoice.payments.build}

      respond_to do |format|
         format.html # new.html.erb
         format.json { render json: @invoice }
      end
   end

   # GET /invoices/1/edit
   def edit
      @invoice = Invoice.find(params[:id])
   end

   # POST /invoices
   # POST /invoices.json
   def create
      @articles = Article.con_nombre(params[:q]) if params[:q].present?
      @invoice = @customer.invoices.new(params[:invoice])
      @id = @invoice.orders(params[:articles_id])
      @quantity = Article.quantity_order(@id)


      respond_to do |format|
         if @invoice.save
            format.html { redirect_to [@customer, @invoice], notice: 'Invoice was successfully created.' }
            format.json { render json: @invoice, status: :created, location: @invoice }
         else
            format.html { render action: "new" }
            format.json { render json: @invoice.errors, status: :unprocessable_entity }
         end
      end
   end

   # PUT /invoices/1
   # PUT /invoices/1.json
   def update
      @invoice = Invoice.find(params[:id])

      respond_to do |format|
         if @invoice.update_attributes(params[:invoice])
            format.html { redirect_to  customer_invoices_path(@customer), notice: 'Invoice was successfully updated.' }
            format.json { head :no_content }
         else
            format.html { render action: "edit" }
            format.json { render json: @invoice.errors, status: :unprocessable_entity }
         end
      end
   end

   # DELETE /invoices/1
   # DELETE /invoices/1.json
   def destroy
      @invoice = Invoice.find(params[:id])
      @invoice.destroy

      respond_to do |format|
         format.html { redirect_to invoices_url }
         format.json { head :no_content }
      end
   end

   def cancelar_invoice

      @invoice  =   Invoice.find(params[:invoice_id])

      respond_to do |format|
         if @invoice.update_attribute("cancelar_invoice",  true )
            format.html { redirect_to  customer_invoices_path(@customer), notice: 'Invoice was successfully updated.' }
            format.json { head :no_content }
         else
            format.html { render action: "edit" }
            format.json { render json: @invoice.errors, status: :unprocessable_entity }
         end
      end
   end

   def update_invoice

      @invoice  =   Invoice.find(params[:invoice_id])
      @order = @invoice.orders
      @price_invoice_total = 0
         @order.each do |product|
         
               @article = Article.find(product.articles_id) 
               @price_unit = @article['price_total'].to_f
               @price_total = (@price_unit  - (@price_unit * (product.discount)/100)) * product.quantity

               product.update_attributes!(unit_price: @price_unit, price_total: @price_total)
               @price_invoice_total += @price_total
         end

               @invoice.update_attributes!( price_total: @price_invoice_total)
      respond_to do |format|
         if '1'=='1'
            format.html { redirect_to  customer_invoices_path(@customer), notice: 'Invoice was successfully updated.' }
            format.json { head :no_content }
         else
            format.html { render action: "edit" }
            format.json { render json: @invoice.errors, status: :unprocessable_entity }
         end
      end
   end

   private

   def load_customers
      @customer = Customer.find(params[:customer_id])
   end
end
