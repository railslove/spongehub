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

  protected

  def match_rated_token
    if self.rated_id.blank? && token = self.text.match(/@([^\W]+)/)
      if user = self.space.users.by_exact_query(token[1]).first
        self.rated_id = user.id
      end
    end
  end
end
