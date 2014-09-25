class GroupLabel < ActiveRecord::Base
  attr_accessible :label_id, :name, :labels_attributes

  has_many :labels

   accepts_nested_attributes_for :labels, :reject_if => lambda {|a| a[:article_id].blank?}

end
