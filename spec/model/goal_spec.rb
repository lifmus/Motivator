require 'spec_helper'

describe Goal do
  before { @goal = Fabricate(:goal) }
  subject { @goal }

  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:due_date) }
  it { should validate_presence_of(:user_id) }
  it { should respond_to(:due_date) }
  it { should respond_to(:description) }
  it { should belong_to(:user) }
  it { should have_many(:objectives)}
  it { should have_many(:steps).through(:objectives) }

  it "throws an error if a goal doesn't have a user, description, or due date" do
    expect { Goal.create }.should raise_error
  end

  it "creates a goal with a user, description, and due date" do
    Goal.create(:user_id => 1, :due_date => Time.now + 6.months, :description => "go to the gym").should be_valid
  end

end