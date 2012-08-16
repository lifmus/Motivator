class Charge < ActiveRecord::Base
  attr_accessible :amount, :goal_id, :stripe_charge_id, :transaction_type

  belongs_to :goal

  scope :initial_charge, where(:transaction_type => 'initial charge')

  after_create :send_to_stripe

  def send_to_stripe(opts = {})
    if self.transaction_type == "refund"
      charge = Stripe::Charge.retrieve(stripe_charge_id)
      charge.refund(:amount => amount)
    else
      charge = Stripe::Charge.create(
        :amount => amount, # in cents
        :currency => "usd",
        :customer => goal.user.stripe_customer_id
      )
    end

    self.stripe_charge_id = charge.id
  end

end
