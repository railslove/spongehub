class Space < ActiveRecord::Base
  attr_accessible :name, :picture

  validates :name, :presence => true
end
