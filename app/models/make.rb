class Make < ActiveRecord::Base
  attr_accessible :comment, :name

#Relación 
  has_many :model, :dependent => :destroy

end
