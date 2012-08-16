class Goal < ActiveRecord::Base
  attr_accessible :description, :due_date, :user_id, :objectives_attributes, :created_at, :public
  validates_presence_of :user_id, :description, :due_date
  belongs_to :user
  has_many :objectives, :inverse_of => :goal
  has_many :steps, :through => :objectives
  has_many :charges
  has_one :pledge
  accepts_nested_attributes_for :objectives
  validates_datetime :due_date, :on_or_after => :two_weeks_ahead, :on_or_before => :one_year_ahead
  validates_length_of :description, :maximum => 140

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
    completed = ((self.objectives.first.steps.count.to_f / total_steps) * 100 ).floor
    if completed > 100
      100
    else
      completed
    end
  end

  def expected_percentage_complete
    ((self.elapsed_days.to_f / self.duration) * 100).floor
  end

  def pledge_amount
    # TODO remove this method; goal.pledge.amount is equivalent
    # TODO add migration to set default value of amount to 0
    # TODO change pledge.amount field from decimal to integer
    self.pledge ? self.pledge.amount : 0
  end

  def full_pledge_amount_refunded?
    pledge.refunded_back >= pledge_amount
  end

  def step_value
    (self.pledge_amount.to_f / self.total_steps)#.round(2) # TODO May need to put this back.
  end

  def pledge_amount_earned_back
    @earned = self.step_value * self.objectives.first.steps.count 
      if @earned > self.pledge_amount
        self.pledge_amount
      else
        @earned
      end    
  end

  def initial_charge
    charges.initial_charge.first
  end

  def step_count_for_previous_period(num = 7)
    steps.where("(completed_at BETWEEN ? AND ?)", Time.now - num.days, Time.now).count
  end

  def nonrefunded_step_count_for_previous_week(num = 7)
    steps.where("(completed_at BETWEEN ? AND ?) AND refunded_at IS NULL", Time.now - num.days, Time.now).count
  end

  def nonrefunded_steps_for_previous_week(num = 7)
    steps.where("(completed_at BETWEEN ? AND ?) AND refunded_at IS NULL", Time.now - num.days, Time.now)
  end

  def refund_amount_for_previous_week
    # nonrefunded_step_count_for_previous_week * step_value
    nonrefunded_steps_for_previous_week.count * step_value
  end

  def weekly_goal_refund
    if refund_amount_for_previous_week > 0 && !full_pledge_amount_refunded?
      user.refund_money((refund_amount_for_previous_week * 100).to_i, initial_charge.stripe_charge_id, self)
      nonrefunded_steps_for_previous_week.each do |step|
        step.refunded_at = Time.now
        step.save
      end
      pledge.refunded_back += (refund_amount_for_previous_week * 100).to_i
      pledge.save
    else
      # TODO Send email to encourage them to do their steps.
    end
  end

end
