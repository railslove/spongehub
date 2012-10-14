class Chore < ActiveRecord::Base
  attr_accessible :taker_id, :creator_id, :description, :due_at, :space_id, :title

  belongs_to :creator, class_name: 'User'
  belongs_to :taker, class_name: 'User'
  belongs_to :space
  has_many :ratings

  validates :title, presence: true
  validates :space_id, presence: true
  validates :creator_id, presence: true

  scope :untaken, where("taker_id IS NULL")
  scope :upcoming, where('DATE(due_at) >= DATE(NOW()) OR due_at IS NULL')
  scope :dateless, where("due_at IS NULL")
  scope :for_month, ->(date) { where("due_at BETWEEN DATE('#{date.beginning_of_month}') AND DATE('#{date.end_of_month}')") }
  scope :random, order('RAND()')


  def self.suggested
    base_scope = self.upcoming.untaken

    scope = base_scope.where('DATE(due_at) = ?', Date.today).random
    matches = scope.size
    if matches == 0
      scope = base_scope.where('DATE(due_at) IS NULL').random
      matches = scope.size
    end

    if matches == 0
      if item_on_next_date = base_scope.order('due_at ASC').first
        scope = base_scope.where('DATE(due_at) = ?', item_on_next_date.due_at.to_date).random
        matches = scope.size
      end
    end

    if matches == 0
      scope = base_scope.random
    end

    scope
  end

  def done?
    !self.done_at.blank?
  end

end
