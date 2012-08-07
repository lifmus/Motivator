class Objective < ActiveRecord::Base
  attr_accessible :description, :frequency, :goal_id
  belongs_to :goal
  has_many :steps
  validates_presence_of :description, :frequency, :goal_id
end
