class Article < ActiveRecord::Base

      scope :con_nombre, ->(nombre){where("LOWER(name) LIKE ?", "%#{nombre}%".downcase)}

    scope :con_id, ->(id){ where('id = ?', "#{id}")}
        attr_accessible :name, :percentaje, :price_cost, :price_total

  belongs_to :order
  has_many :invoices

    def self.quantity_order(id)

        id.each do |b|
             stock_current = Article.find(b.articles_id).quantity
             quantity = b.quantity
              stock = stock_current - quantity

            Article.find_by_id(b.articles_id).update_attribute(:quantity, stock)


        end
    end



end
