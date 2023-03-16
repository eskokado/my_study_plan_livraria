FactoryBot.define do
  factory :assembly_with_parts_and_books, class: 'Assembly' do
    name { Faker::Company.name }

    transient do
      parts_count { 2 }
      books_count { 1 }
    end

    after(:create) do |assembly, evaluator|
      create_list(:part, evaluator.parts_count, assemblies: [assembly])
      create_list(:book, evaluator.books_count, assemblies: [assembly])
    end
  end
end
