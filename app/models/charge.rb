class Charge < ActiveRecord::Base
  attr_accessible :amount, :goal_id, :stripe_charge_id, :transaction_type

  belongs_to :goal

  # before_create :ping_stripe

  scope :initial_charge, where(:transaction_type => 'initial charge')

  # def refund
  #   where(:transaction_type => 'refund')
  # end
  #
  # def ping_stripe
  #   if transaction_type == 'initial charge'
  #     get_money
  #   else
  #     refund_money
  #   end
  # end

end
