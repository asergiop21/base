class Article < ActiveRecord::Base

      scope :con_nombre, ->(nombre){where("LOWER(name) LIKE ?", "%#{nombre}".downcase)}
      
      
        attr_accessible :name, :percentaje, :price_cost, :price_total

  belongs_to :order
  has_many :invoices

end
