require 'spec_helper'

describe User do

  describe "charge card" do
    before :each do
      @user = Fabricate(:user_with_goal)
      @user.stripe_customer_id = "cus_090KkrnnLdiJuX"
      @user.save
    end

    it "should be able to charge a user" do
      @user.charge_card(10000, @user, @user.goals.first)
      Charge.last.amount.should eq 10000
    end

    it "should create a new charge object in the database" do
      @user.charge_card(50, @user, @user.goals.first)
      Charge.last.amount.should eq 50
      Charge.last.stripe_charge_id.should be
      Charge.last.transaction_type.should eq "initial charge"
    end
  end

  describe "refund money" do

    before :each do
      @user = Fabricate(:user_with_goal)
      @user.stripe_customer_id = "cus_090KkrnnLdiJuX"
      @user.save
    end

    it "should be able to refund a charge" do
      @user.charge_card(5000, @user, @user.goals.first)
      @user.refund_money(100, Charge.last.stripe_charge_id, @user.goals.first)
      Charge.last.amount.should eq 100
      Charge.last.transaction_type.should eq "refund"
    end
  end

  describe ".refund_all_goals_for_previous_week" do
    it "refunds the amounts for all users and their goals"
  end

  describe "#create_stripe_customer_id(stripeToken)" do
    let(:user) { Fabricate(:user) }

    it "creates a stripe_customer_id" do
      mock_customer = mock()
      mock_customer.stub(:id).and_return("test")
      Stripe::Customer.stub(:create).and_return(mock_customer)

      expect { user.create_stripe_customer_id("testToken") }.to change{user.reload.stripe_customer_id}.from(nil).to("test")
    end
  end
end
