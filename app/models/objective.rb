class Objective < ActiveRecord::Base
  attr_accessible :description, :frequency, :goal_id
  belongs_to :goal, :inverse_of => :objectives
  has_many :steps
  validates_presence_of :description, :frequency, :goal

  def build_steps
    7.times do |num|
      steps.build(:created_at => Time.now.beginning_of_week + num.days)
    end
  end
end
