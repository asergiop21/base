class Invoice < ActiveRecord::Base
 
        attr_accessible :customer_id, :price_total, :orders_attributes


 has_many  :orders
 belongs_to :customer

 accepts_nested_attributes_for :orders

end
