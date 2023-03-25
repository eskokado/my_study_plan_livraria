FactoryBot.define do
  factory :part_with_book, class: Part do
    part_number { Faker::Number.number.to_s }
    name { Faker::Lorem.name }
    value { Faker::Number.between(from: 100, to: 400) }
    book
    supplier
  end
end
