FactoryBot.define do
  factory :tenant do
    name { Faker::Company.name }
    access_count { 0 }
  end
end
