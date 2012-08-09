Fabricator(:pledge) do
  goal_id { Fabricate(:goal) }
  amount { rand(100) }
end