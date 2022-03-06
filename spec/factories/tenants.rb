FactoryBot.define do
  factory :tenant do
    name { "#{Faker::Company.name}-#{SecureRandom.hex(16).last(5)}" }
    access_count { 0 }
  end
end
