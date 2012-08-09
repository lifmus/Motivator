class Charge < ActiveRecord::Base
  attr_accessible :amount, :goal_id, :stripe_charge_id

  belongs_to :goal
end
