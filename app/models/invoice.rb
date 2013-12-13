class Invoice < ActiveRecord::Base
 
        attr_accessible :customer_id, :price_total, :orders_attributes, :payments_attributes


 has_many  :orders
 has_many  :payments
 belongs_to :customer

 accepts_nested_attributes_for :orders
 accepts_nested_attributes_for :payments


def self.total_amount
        sum('price_total')
end

def self.sum_pay(id)
      Payment.where('invoice_id = ?', id).sum('amount')

end


end
