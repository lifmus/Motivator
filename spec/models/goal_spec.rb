require 'spec_helper'

describe Goal do

  describe "goal field validations" do
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
      Goal.create().should_not be_valid
    end

    it "doesn't allow goals with a due date in the past" do
     Goal.create(:user_id => 1, :description => "new goal", :due_date => Time.now - 2.months).should_not be_valid
    end

    it "doesn't allow goals with a due date less than two weeks in the future" do
     Goal.create(:user_id => 1, :description => "new goal", :due_date => (Time.now + 1.week)).should_not be_valid
    end

    it "doesn't allow goals with a due date more than one year in the future" do
     Goal.create(:user_id => 1, :description => "new goal", :due_date => (Time.now + 2.years)).should_not be_valid
    end


    it "creates a goal with a user, description, and due date" do
      Goal.create(:user_id => 1, :due_date => Time.now + 6.months, :description => "go to the gym").should be_valid
    end

    it "cannot take more than 140 characters for the goal" do
      Goal.create(:user_id => 1, :due_date => Time.now + 6.months, :description => "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" ).should_not be_valid
    end

  end

  describe "progress methods" do

    before :each do
      @started_date = Time.now.to_date - 4.weeks
      @due_date = Time.now.to_date + 4.weeks
      @goal = Goal.create(:created_at => @started_date, :user_id => 1, :due_date => @due_date, :description => "Become a Black Belt")
      @goal.objectives.create(:description => "Go to Karate Class", :frequency => 3)
      @goal.create_pledge(:amount => 450)
    end

    it "calculates the duration in weeks" do
      @goal.duration_in_weeks.should eq 8/1
    end

    it "calculates the total steps required to achieve goal" do
      @goal.total_steps.should eq 24
    end

    it "has a weekly rate based on the frequency of its objectives" do
      @goal.weekly_rate.should eq 3
    end

    it "has elapsed days based on today's date and created date" do
      @goal.elapsed_days.should eq 28
    end

    it "should be able to calculate current Goal progress as a percentage" do
      4.times do
        @goal.objectives.last.steps.create(:completed_at => Time.now)
      end
      @goal.percentage_complete.should eq 16
    end

    it "calculates the expected progress as a percentage based on the current date" do
      goal_2 = Goal.create(:created_at => @started_date, :user_id => 1, :description => "become a yellow belt", :due_date => @due_date)
      goal_2.objectives.create(:description => "Go to Karate Class", :frequency => 3)
      goal_2.expected_percentage_complete.should eq 50
    end

    it "has a step value" do
      @goal.step_value.should eq 18.75 # 19
    end

  end

  describe "financial progress" do

    before :each do
      @started_date = Time.now.to_date - 4.weeks
      @due_date = Time.now.to_date + 4.weeks
      @goal = Goal.create(:created_at => @started_date, :user_id => 1, :due_date => @due_date, :description => "Become a Black Belt")
      @objective = @goal.objectives.create(:description => "Go to Karate Class", :frequency => 3)
      @goal.build_pledge(:amount => "450")
      @objective.steps.create(:completed_at => @started_date + 1.week)
      @objective.steps.create(:completed_at => @started_date + 2.weeks)
      @objective.steps.create(:completed_at => @started_date + 3.weeks)
    end

    it "has a total pledge amount" do
      @goal.pledge_amount.should eq 450
    end

    it "calculates the pledge amount earned" do
      @goal.pledge_amount_earned_back.should eq 56.25 # 57
    end

    describe "#initial_charge" do
      it "has an initial charge"
    end

  end

  describe "#readable_date" do
    let(:goal) { Fabricate(:goal) }

    it "formats the due date to be readable" do
      goal.readable_date.should eq goal.due_date.to_date.to_formatted_s(:long)
    end
  end

  describe "#step_count_for_previous_period(num = 7)" do
    it "counts the completed steps for a previous period"
  end

  describe "#refund_amount_for_previous_week" do
    it "calculates the amount to be refunded for the previous week"
  end

  describe "#weekly_goal_refund" do
    it "refunds the amount for the previous week to the user"
    it "increments the pledge's refunded back amount"
  end

end

