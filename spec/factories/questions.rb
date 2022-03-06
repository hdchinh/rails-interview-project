FactoryBot.define do
  factory :question do
    title { Faker::Lorem.sentence }
    asker factory: :user
  end

  factory :private_question, parent: :question do
    private { true }
  end

  factory :publish_question, parent: :question do
    private { false }
  end
end
