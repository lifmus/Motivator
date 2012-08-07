Fabricator(:objective) do
  description { Faker::Lorem.sentence(1) }
  frequency { 3 }
  goal_id { Fabricate(:goal) }
end