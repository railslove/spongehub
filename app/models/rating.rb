class Rating < ActiveRecord::Base
  attr_accessible :chore_id, :creator_id, :image, :rated_id, :space_id, :text, :value

  mount_uploader :image, ImageUploader

  belongs_to :creator, class_name: 'User'
  belongs_to :rated, class_name: 'User'
  belongs_to :space
  belongs_to :chore

  validates :value, :numericality => true
  validates :space, :presence => true
  validates :text, :presence => true

  before_save :match_rated_token
  after_save :notify_user

  protected

  def match_rated_token
    if self.rated_id.blank? && matched_user = TextUserTokenizer.new(text, space.users).unique_match
      self.rated_id = matched_user.id
    end
  end

  def blame?
    self.value == -1
  end

  def fame?
    self.value == 1
  end

  def notify_user
    UserMailer.blame_or_fame(self.rated, self.space).deliver if self.rated.present? && self.rated.email.present?
  end
end