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
        # fill_in "goal_objectives_attributes_0_frequency", with: 3
        select("3", :from => "goal_objectives_attributes_0_frequency")
        click_button "I'm ready to get motivated"
        fill_in "pledge_amount", with: 150
        click_button "Submit my pledge"

      end

      it {should have_content("Card Number")}
      it {should have_content("CVC")}
      it {should have_content("Expiration (MM/YYYY)")}

      describe "save a valid credit card" do
        before :each do
          fill_in "card-number", with: "4242424242424242"
          fill_in "card-cvc", with: "111"
          fill_in "card-expiry-month", with: "10"
          fill_in "card-expiry-year", with: Time.now + 2.years
        end

        it "creates the stripe_customer_id" do
          mock_customer = mock()
          mock_customer.stub(:id).and_return("test")
          Stripe::Customer.stub(:create).and_return(mock_customer)

          expect { click_link_or_button "Save Credit Card" }.to change{user.reload.stripe_customer_id}.from(nil).to("test")
        end
      end

    end
  end
end



