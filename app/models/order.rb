class Order < ActiveRecord::Base
  attr_accessible :articles_id, :invoice_id, :price_total, :quantity, :unit_price, :name, :quantity_stock

  attr_accessor :quantity_stock


  has_many :articles
  belongs_to :invoice




end
