class Article < ActiveRecord::Base
        scope :con_nombre_barcode,  ->(nombre){where("LOWER(name) LIKE ? or barcode LIKE ?", "%#{nombre}%".downcase, "%#{nombre}%")  }
        scope :con_nombre,   ->(nombre){where("LOWER(name) LIKE ?", "%#{nombre}%".downcase)  }
        scope :con_id, ->(id){ where('id = ?', "#{id}")}
        scope :proveedor, ->(supplier_id){where('supplier_id = ?', "#{supplier_id}")}

        attr_accessible :name, :percentaje, :price_cost, :price_total, :make_id, :new_category, :category_id, :quantity, :barcode, :articles_code_supplier, :supplier_id, :new_supplier, :new_quantity, :new_make


        attr_accessor :new_category, :new_supplier, :new_quantity, :new_make

        belongs_to :order
        belongs_to :category
        belongs_to :make
        belongs_to :supplier
        has_many :invoices

        before_save :create_category
        before_save :create_supplier
        before_save :create_make
        before_save :update_quantity

        validates :name, :price_cost, :percentaje, :quantity,  presence: true

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
        def create_make
                self.make = Make.create!(name: new_make) if new_make.present?
        end
        def update_quantity
                self.quantity += new_quantity.to_f
        end
end
