Fabricator(:user) do
  email { Faker::Internet.email }
  password { "password" }
end