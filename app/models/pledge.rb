class Pledge < ActiveRecord::Base
  attr_accessible :amount, :goal_id
  validates_presence_of :goal_id
  validates_presence_of :amount
  belongs_to :goal

  def self.suggested_amount(goal)
    weeks = goal.duration / 7
    total_steps = weeks * goal.objectives.first.frequency
    [total_steps, (total_steps * 5), (total_steps * 10)]
  end

  def goal
    Goal.find(self.goal_id)
  end
end
