require 'spec_helper'

describe Pledge do
  before { @pledge = Fabricate(:pledge) }
  subject { @pledge }

  it { should validate_presence_of(:goal_id) }
  it { should validate_presence_of(:amount) }

  it { should belong_to(:goal) }

  describe "suggested pledge amount" do
    it "suggests a pledge amount based on the goal duration/frequency of the objective" do
      @goal = Goal.create(:user_id => 1, :description => "learn karate", :due_date => Time.now + 10.weeks)
      @goal.objectives.create(:frequency => 3, :description => "go to karate class")
      Pledge.suggested_amount(@goal).should have(3).things
    end
  end

end
