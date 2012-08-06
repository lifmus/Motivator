class Objective < ActiveRecord::Base
  attr_accessible :description, :frequency, :goal_id
  belongs_to :goal, :class_name => "Goal", :foreign_key => "goal_id"
  has_many :steps
end
