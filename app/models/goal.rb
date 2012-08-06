class Goal < ActiveRecord::Base
  attr_accessible :description, :due_date, :user_id
end
