require 'spec_helper'

describe "Credit Card pages" do
  subject { page }
  let(:user) { Fabricate(:user_with_goal) }


  describe "credit_card#new" do

    describe "when logged out" do
      before { visit new_creditcard_path }
      it { should have_content('Sign in') }
    end # when logged out

    describe "when logged in" do
      before :each do
        visit new_user_session_path
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
        visit new_goal_path
        fill_in "goal_description", with: "become a dinosaur"
        fill_in "goal_due_date", with: Time.now + 3.weeks
        fill_in "goal_objectives_attributes_0_description", with: "eat magical eggs"
        fill_in "goal_objectives_attributes_0_frequency", with: 3
        click_button "I'm ready to get motivated"
        fill_in "pledge_amount", with: 150
        click_button "Submit my pledge"

      end

        it {should have_content("Card Number")}
        it {should have_content("CVC")}
        it {should have_content("Expiration (MM/YYYY)")}

        ## test below can't run without selenium/javascript testing framework

        # it "should fill in the information" do
        #   fill_in "card-number", with: "4242424242424242"
        #   fill_in "card-cvc", with: "111"
        #   fill_in "card-expiry-month", with: "10"
        #   fill_in "card-expiry-year", with: "2015"
        #
        #   click_button "Submit Payment"
        #   # sleep 10
        #   user.stripe_customer_
        #   p user
        #   p user.stripe_customer_id
        #   p "*********************"
        #   click_button "YES"
        #   Charge.last.amount.should eq 15000

        #end

    end
  end
end



