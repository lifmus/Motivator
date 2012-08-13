Fabricator(:user) do
  email { Faker::Internet.email }
  password { "password" }
end

Fabricator(:user_with_goal, :from => :user) do
  goals(:count => 1) { Fabricate(:goal_with_objective) }
end