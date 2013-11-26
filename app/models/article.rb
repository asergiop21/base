class Article < ActiveRecord::Base
        scope :con_nombre, ->(nombre){where("LOWER(name) LIKE ?", "%#{nombre}%".downcase)}
        scope :con_id, ->(id){ where('id = ?', "#{id}")}
        attr_accessible :name, :percentaje, :price_cost, :price_total, :new_category, :category_id, :quantity, :barcode, :articles_code_supplier, :supplier_id, :new_supplier, :new_quantity
        attr_accessor :new_category, :new_supplier, :new_quantity

        belongs_to :order
        belongs_to :category
        belongs_to :supplier
        has_many :invoices

        before_save :create_category
        before_save :create_supplier
        before_save :update_quantity

        validates :name, :price_cost, :percentaje,  :quantity,  presence: true
   
   
        def self.quantity_order(id)
                id.each do |b|
                        stock_current = Article.find(b.articles_id).quantity
                        quantity = b.quantity
                        stock = stock_current - quantity
                        Article.find_by_id(b.articles_id).update_attribute(:quantity, stock)
                end
        end

        def create_category
                self.category = Category.create!(name: new_category) if new_category.present?
        end

        def create_supplier
                self.supplier = Supplier.create!(name: new_supplier) if new_supplier.present?
        end

        def update_quantity
                self.quantity += new_quantity.to_f
        end



end
