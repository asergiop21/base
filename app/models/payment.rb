class Payment < ActiveRecord::Base
  attr_accessible :amount, :invoice_id, :description

belongs_to :invoice






end
