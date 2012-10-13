class Space < ActiveRecord::Base
  attr_accessible :name, :picture

  has_many :chores, dependent: :destroy

  validates :name, :presence => true
end
