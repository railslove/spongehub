class User < ActiveRecord::Base
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  attr_accessible :name, :email

  has_many :chores, dependent: :destroy, foreign_key: "taker_id"
  has_many :ratings, dependent: :destroy
  has_many :fames,  class_name: "Rating", foreign_key: "rated_id", conditions: "value > 0"
  has_many :blames, class_name: "Rating", foreign_key: "rated_id", conditions: "value < 0"

  has_and_belongs_to_many :spaces

  after_save :update_identity_email

  validates_uniqueness_of :email
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

  scope :by_query, lambda { |term| where('name LIKE ?', "%#{term}%") }
  scope :by_exact_query, lambda { |term| where('LOWER(name) = ?', "#{term.downcase}") }
  scope :with_karma, lambda {
    select('users.*, COALESCE(SUM(ratings.value), 0) as raw_karma').
      joins('LEFT JOIN ratings ON ratings.rated_id = users.id').
      group('users.id').
      order('raw_karma DESC')
  }

  def remote_image_url
    read_attribute(:remote_image_url).presence || asset_path("fallbacks/default_remote_image.png")
  end

  def update_identity_email
    authentication = Authentication.find_by_user_id_and_provider(self.id, "identity")
    identity = authentication.identity if authentication
    unless identity.blank?
      identity.email = self.email
      identity.save!
    end
  end

  def karma
    if self.respond_to?(:raw_karma)
      raw_karma.to_i
    else
      100
    end
  end

end
