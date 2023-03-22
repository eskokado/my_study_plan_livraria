FactoryBot.define do
  factory :assembly_with_parts, class: 'Assembly' do
    name { Faker::Company.name }

    transient do
      parts_count { 2 }
    end

    after(:create) do |assembly, evaluator|
      evaluator.parts_count.times do
        part = create(:part)
        create(:assemblies_part, assembly: assembly, part: part)
      end
    end
  end
end
