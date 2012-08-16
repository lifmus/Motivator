class Pledge < ActiveRecord::Base
  attr_accessible :amount, :goal_id, :refunded_back
  validates_presence_of :goal_id
  validates_presence_of :amount
  belongs_to :goal

  def self.suggested_amount(goal)
    [goal.total_steps, (goal.total_steps * 5), (goal.total_steps * 10)]
  end
end
