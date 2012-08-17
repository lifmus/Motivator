class Objective < ActiveRecord::Base
  attr_accessible :description, :frequency, :goal_id
  belongs_to :goal, :inverse_of => :objectives
  has_many :steps, :dependent => :destroy
  validates_presence_of :description, :frequency, :goal
  validates_length_of :description, :maximum => 140

  def build_steps
    7.times do |num|
      steps.build(:created_at => Time.now.beginning_of_week + num.days)
    end
  end
end
