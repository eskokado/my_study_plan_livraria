FactoryBot.define do
  factory :book do
    published_at { Faker::Date.backward(days: 365) }
    author
  end
end
