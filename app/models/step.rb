class Step < ActiveRecord::Base
  attr_accessible :completed_at, :objective_id
  belongs_to :objective, :class_name => "Objective", :foreign_key => "objective_id"

  validates_presence_of :completed_at, :objective_id
  validates_uniqueness_of :completed_at, :scope => :objective_id #BUGBUG completed_at does not take into account time
end
