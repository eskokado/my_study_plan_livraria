FactoryBot.define do
  factory :account do
    account_number { Faker::Number.number(digits: 10) }
    supplier
  end
end
