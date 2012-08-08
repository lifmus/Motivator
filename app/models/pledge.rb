class Pledge < ActiveRecord::Base
  attr_accessible :amount, :goal_id
end
