class Rating < ActiveRecord::Base
  attr_accessible :chore_id, :creator_id, :image, :rated_id, :space_id, :text, :value

  mount_uploader :avatar, ImageUploader

  validates :value, :numericality => true
  validates :space, :presence => true
end
