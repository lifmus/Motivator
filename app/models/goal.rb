class Goal < ActiveRecord::Base
  attr_accessible :description, :due_date, :user_id, :objectives_attributes

  validates_presence_of :user_id, :description, :due_date

  belongs_to :user
  has_many :objectives, :inverse_of => :goal
  has_many :steps, :through => :objectives

  accepts_nested_attributes_for :objectives

end
