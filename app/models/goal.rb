class Goal < ActiveRecord::Base
  attr_accessible :description, :due_date, :user_id, :objectives_attributes, :created_at

  validates_presence_of :user_id, :description, :due_date

  belongs_to :user
  has_many :objectives, :inverse_of => :goal
  has_many :steps, :through => :objectives

  accepts_nested_attributes_for :objectives



  def percentage_complete
    total_days = (self.due_date.to_date - self.created_at.to_date).to_i
    daily_rate = self.objectives.first.frequency.to_f / 7
    expected_steps = total_days * daily_rate
    ((self.objectives.first.steps.count.to_f / expected_steps) * 100 ).floor
  end

  def expected_percentage_complete
    total_days = (self.due_date.to_date - self.created_at.to_date).to_i
    elapsed_days = (Time.now.to_date - self.created_at.to_date).to_i
    (elapsed_days.to_f / total_days) * 100
  end

end
