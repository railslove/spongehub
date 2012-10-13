class Space < ActiveRecord::Base
  attr_accessible :name, :image

  mount_uploader :image, ImageUploader

  has_many :chores, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_and_belongs_to_many :users

  validates :name, :presence => true
end
