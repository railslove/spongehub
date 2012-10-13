class User < ActiveRecord::Base
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  attr_accessible :name

  has_many :chores, dependent: :destroy, foreign_key: "taker_id"
  has_many :ratings, dependent: :destroy
  has_many :fames,  class_name: "Rating", foreign_key: "rated_id", conditions: "value > 0"
  has_many :blames, class_name: "Rating", foreign_key: "rated_id", conditions: "value < 0"

  has_and_belongs_to_many :spaces

  def remote_image_url
    read_attribute(:remote_image_url).presence || asset_path("fallbacks/default_remote_image.png")

  def self.find_by_query(term)
    self.where('name LIKE ?', "%#{term}%")
  end

end
