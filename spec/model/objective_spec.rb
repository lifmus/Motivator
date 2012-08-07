require 'spec_helper'

describe Objective do
  before { @objective = Fabricate(:objective) }
  subject { @objective }

  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:frequency) }
  it { should validate_presence_of(:goal_id) }
  it { should respond_to(:frequency) }
  it { should respond_to(:description) }
  it { should have_many(:steps)}


  it "throws an error if an objective doesn't have a frequency, description, or goal id" do
    expect { Objective.create }.should raise_error
  end

  it "creates an objective with a frequency, description, and goal id" do
    Objective.create(:goal_id => 1, :frequency => 3, :description => "is a great word").should be_valid
  end

end