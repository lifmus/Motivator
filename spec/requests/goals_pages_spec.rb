#TODO move to views folder when we figure out why this file doesn't work from there
require 'spec_helper'

describe "Goals pages" do
  subject { page }
  let(:user) { Fabricate(:user) }
  let(:goal) { Fabricate(:goal_with_objective) }

  describe "goals#edit" do

    describe "when logged out" do
      before { visit goal_path(goal) }
      it { should have_content('Sign in') }
    end # when logged out

    describe "when logged in" do
      before do
        visit new_user_session_path
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
        visit edit_goal_path(goal)
      end

      it { should have_content(goal.description) }
      it { should have_content('When did you') }
      it { should have_content(goal.due_date.strftime("%a %b #{goal.due_date.day.ordinalize}")) }

      # describe "'New Project' creates a new project in the database" do
      #         before do
      #           fill_in "Name", with: "Googly Moogly"
      #           fill_in "Description", with: "F'in things up!"
      #         end
      #
      #         it "should create the project" do
      #           expect { click_button 'Create Project'}.to change(Project, :count).by(1)
      #         end
      #
      #         describe "displays the project in the list of projects" do
      #           before { click_button 'Create Project' }
      #           it { should have_content("Googly Moogly") }
      #           it { should have_content("F'in things up!") }
      #         end

    end # when logged in
  end # goals#show
end
