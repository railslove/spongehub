class User < ActiveRecord::Base
  attr_accessible :name

  has_many :chores, dependent: :destroy, foreign_key: "taker_id"
  has_many :ratings, dependent: :destroy
  has_many :fames,  class_name: "Rating", foreign_key: "rated_id", conditions: "value > 0"
  has_many :blames, class_name: "Rating", foreign_key: "rated_id", conditions: "value < 0"

  has_and_belongs_to_many :spaces

  def self.find_by_query(term)
    self.where('name LIKE ?', "%#{term}%")
  end

end
