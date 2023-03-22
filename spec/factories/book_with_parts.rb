FactoryBot.define do
  factory :book_with_parts, class: Book do
    published_at { Faker::Date.between(from: '2023-01-01', to: '2023-03-15') }
    isbn { Faker::Code.isbn(base: 13) }
    title { Faker::Book.title }
    author

    transient do
      parts_count { 2 }
    end

    after(:create) do |book, evaluator|
      create_list(:part, evaluator.parts_count, book: book)
    end
  end
end
