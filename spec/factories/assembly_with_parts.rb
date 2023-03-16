FactoryBot.define do
  factory :assembly_with_parts, class: 'Assembly' do
    name { Faker::Company.name }

    transient do
      parts_count { 2 }
    end

    after(:create) do |assembly, evaluator|
      create_list(:part, evaluator.parts_count, assemblies: [assembly])
    end
  end
end
