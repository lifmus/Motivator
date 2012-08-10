class Charge < ActiveRecord::Base
  attr_accessible :amount, :goal_id, :stripe_charge_id, :transaction_type

  belongs_to :goal
end
