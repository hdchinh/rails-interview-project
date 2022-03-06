FactoryBot.define do
  factory :answer do
    body { Faker::Lorem.sentence }
    question
    answerer factory: :user
  end
end
