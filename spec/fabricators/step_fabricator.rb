Fabricator(:step) do
  completed_at { Time.now - 2.days }
  objective_id { Fabricate(:objective) }
end