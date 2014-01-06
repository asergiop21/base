class Invoice < ActiveRecord::Base
 
        attr_accessible :customer_id, :price_total, :orders_attributes, :payments_attributes, :current_account


 has_many  :orders
 has_many  :payments
 belongs_to :customer

 accepts_nested_attributes_for :orders, :reject_if => lambda {|a| a[:articles_id].blank?}

 accepts_nested_attributes_for :payments, allow_destroy: true


def self.total_amount
        sum('price_total')
end

def self.sum_pay(id)
      Payment.where('invoice_id = ?', id).sum('amount')
end

end
