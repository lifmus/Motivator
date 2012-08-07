Fabricator(:goal) do
  description { Faker::Lorem.sentence(1) }
  due_date { Time.now + 6.months }
  user_id { 1 } # TODO change when we have the user model
end