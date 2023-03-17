FactoryBot.define do
  factory :book do
    published_at { Faker::Date.between(from: '2023-01-01', to: '2023-03-15') }
    isbn { Faker::Code.isbn(base: 13) }
    author
  end
end
