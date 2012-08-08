class Pledge < ActiveRecord::Base
  attr_accessible :amount, :goal_id
  validates_presence_of :goal_id
  validates_presence_of :amount
end
