class Space < ActiveRecord::Base
  attr_accessible :name, :image

  mount_uploader :image, BannerImageUploader

  has_many :chores, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :fames,  class_name: "Rating", conditions: "value > 0"
  has_many :blames, class_name: "Rating", conditions: "value < 0"

  has_and_belongs_to_many :users

  validates :name, :presence => true

  def member?(user)
    user.present? && self.user_ids.include?(user.id)
  end
end
