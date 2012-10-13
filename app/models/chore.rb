class Chore < ActiveRecord::Base
  attr_accessible :taker_id, :creator_id, :description, :due_at, :space_id, :title

  belongs_to :creator, class_name: 'User'
  belongs_to :taker, class_name: 'User'
  belongs_to :space

  validates :title, presence: true
  validates :space_id, presence: true
  validates :creator_id, presence: true

  scope :untaken, where("taker_id IS NULL")
  scope :dateless, where("due_at IS NULL")
  scope :for_month, ->(date) { where("due_at BETWEEN DATE('#{date.beginning_of_month}') AND DATE('#{date.end_of_month}')") }
end
