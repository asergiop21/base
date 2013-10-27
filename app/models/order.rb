class Order < ActiveRecord::Base
  attr_accessible :articles_id, :invoice_id, :price_total, :quantity, :unit_price, :name 


  has_many :articles
  belongs_to :invoice







end
