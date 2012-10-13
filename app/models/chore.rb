class Chore < ActiveRecord::Base
  attr_accessible :assignee_id, :creator_id, :description, :due_at, :space_id, :title

  belongs_to :creator
  belongs_to :space

  validates :title, presence: true
  validates :space_id, presence: true
  validates :creator_id, presence: true

end
