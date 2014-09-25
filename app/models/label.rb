class Label < ActiveRecord::Base
  attr_accessible :article_id, :quantity, :name

  attr_accessor :name
  
  belongs_to :group_label
  belongs_to :article

end
