class Rating < ActiveRecord::Base
  attr_accessible :chore_id, :creator_id, :image, :rated_id, :space_id, :text, :value

  mount_uploader :image, ImageUploader

  belongs_to :creator, class_name: "User"
  belongs_to :space
  belongs_to :chore

  validates :value, :numericality => true
  validates :space, :presence => true
end
