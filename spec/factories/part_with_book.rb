FactoryBot.define do
  factory :part_with_book, class: Part do
    part_number { Faker::Number.number.to_s }
    name { Faker::Lorem.name }
    book
    supplier
  end
end
