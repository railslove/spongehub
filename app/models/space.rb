class Space < ActiveRecord::Base
  attr_accessible :name, :picture

  has_many :chores, dependent: :destroy
  has_and_belongs_to_many :users

  validates :name, :presence => true
end
