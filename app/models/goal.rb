class Goal < ActiveRecord::Base
  attr_accessible :description, :due_date, :user_id, :objectives_attributes, :created_at
  validates_presence_of :user_id, :description, :due_date
  belongs_to :user
  has_many :objectives, :inverse_of => :goal
  has_many :steps, :through => :objectives
  has_many :charges
  has_one :pledge
  accepts_nested_attributes_for :objectives

  def readable_date
    self.due_date.to_date.to_formatted_s(:long)
  end

  def duration
    (self.due_date.to_date - self.created_at.to_date).to_i
  end

  def duration_in_weeks ## unrounded float
    (self.due_date.to_date - self.created_at.to_date) / 7
  end

  def weekly_rate
    self.objectives.first.frequency
  end

  def total_steps
    (self.duration_in_weeks * self.weekly_rate).round
  end

  def elapsed_days
    (Time.now.to_date - self.created_at.to_date).to_i
  end

  def percentage_complete
    ((self.objectives.first.steps.count.to_f / total_steps) * 100 ).floor
  end

  def expected_percentage_complete
    ((self.elapsed_days.to_f / self.duration) * 100).floor
  end

  def pledge_amount
    if self.pledge
      self.pledge.amount
    else
      0
    end
  end

  def step_value
    (self.pledge_amount.to_f / self.total_steps)#.round  #TODO May need to put this back.
  end

  def pledge_amount_earned_back
    self.step_value * self.objectives.first.steps.count
  end

  # def refund_if_refundable
  #   refund_amount = step_count_from_last_week * step_value
  #   if refund_amount > 0
  #     Charge.create(:)
  #     refund_through_stripe
  #   end
  # end

  def initial_charge
    charges.initial_charge.first
  end

  def step_count_for_previous_period(num = 7)
    steps.where("completed_at BETWEEN ? AND ?", Time.now - num.days, Time.now).count
  end

  def refund_amount_for_previous_week
    step_count_for_previous_period * step_value
  end

  def weekly_goal_refund
    user.refund_money((refund_amount_for_previous_week * 100).to_i, initial_charge.stripe_charge_id, self)
    pledge.refunded_back += (refund_amount_for_previous_week * 100).to_i
    pledge.save
  end

end
