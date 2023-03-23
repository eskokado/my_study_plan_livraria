FactoryBot.define do
  factory :part do
    part_number { Faker::Number.number.to_s }
    name { Faker::Lorem.name }
    value { Faker::Number.between(from: 100, to: 400)}
    association :book
    association :supplier
  end
end
