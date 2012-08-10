class Goal < ActiveRecord::Base
  attr_accessible :description, :due_date, :user_id, :objectives_attributes, :created_at
  validates_presence_of :user_id, :description, :due_date
  belongs_to :user
  has_many :objectives, :inverse_of => :goal
  has_many :steps, :through => :objectives
  has_many :charges
  has_one :pledge
  accepts_nested_attributes_for :objectives

  def duration
    (self.due_date.to_date - self.created_at.to_date).to_i
  end

  def percentage_complete
    daily_rate = self.objectives.first.frequency.to_f / 7
    expected_steps = self.duration * daily_rate
    ((self.objectives.first.steps.count.to_f / expected_steps) * 100 ).floor
  end

  def expected_percentage_complete
    elapsed_days = (Time.now.to_date - self.created_at.to_date).to_i
    (elapsed_days.to_f / self.duration) * 100
  end

  def pledge_amount
    self.pledge.amount
  end

  def pledge_amount_earned_back
    self.pledge_amount.to_f * (self.percentage_complete.to_f / 100)
  end

end
