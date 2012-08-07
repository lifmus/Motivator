require 'spec_helper'

describe Step do
  before { @step = Fabricate(:step) }
  subject { @step }

  it { should validate_presence_of(:completed_at) }
  it { should validate_presence_of(:objective_id) }
  it { should respond_to(:completed_at) }
  it { should belong_to(:objective)}


  it "cannot enter duplicate entry with the same date and objective id" do
    new_step = Step.create(:completed_at => @step.completed_at, :objective_id => @step.objective_id )
    new_step.should_not be_valid
  end


  it "throws an error if a step doesn't have a completed_at or objective_id" do
    expect { Step.create }.should raise_error
  end

  it "creates a step with a completed_at and objective_id" do
    objective = Fabricate(:objective)
    Step.create(:completed_at => Time.now - 2.days, :objective_id => objective.id).should be_valid
  end

end