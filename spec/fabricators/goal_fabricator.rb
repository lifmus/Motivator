Fabricator(:goal) do
  description { Faker::Lorem.sentence(1) }
  due_date { Time.now + 6.months }
  created_at { Time.now }
  user_id { Fabricate(:user) } # TODO change when we have the user model
end

Fabricator(:goal_with_objective, :from => :goal) do
  objectives(:count => 1) { Fabricate(:objective) }
end