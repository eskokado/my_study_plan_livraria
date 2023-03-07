FactoryBot.define do
  factory :author do
    name { Faker::Company.name }
  end
end
