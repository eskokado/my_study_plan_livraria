FactoryBot.define do
  factory :assembly_with_parts_and_books, class: 'Assembly' do
    name { Faker::Company.name }

    transient do
      parts_count { 2 }
      books_count { 1 }
      associated_books { [] } # Adicione esta linha
    end

    after(:create) do |assembly, evaluator|
      # Crie as peças e associe-as à montagem
      evaluator.parts_count.times do
        part = create(:part)
        create(:assemblies_part, assembly: assembly, part: part)
      end

      # Crie os livros e associe-os à montagem
      evaluator.books_count.times do
        book = create(:book)
        create(:assemblies_book, assembly: assembly, book: book)
      end

      # Associe os livros fornecidos através do atributo associated_books à montagem
      evaluator.associated_books.each do |book|
        create(:assemblies_book, assembly: assembly, book: book)
      end
    end
  end
end
