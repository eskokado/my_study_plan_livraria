FactoryBot.define do
  factory :assembly_with_books, class: 'Assembly' do
    name { Faker::Company.name }

    transient do
      books_count { 1 }
    end

    after(:create) do |assembly, evaluator|
      create_list(:book, evaluator.books_count, assemblies: [assembly])
    end
  end
end
