FactoryBot.define do
  factory :account do
    account_number { Faker::Number.number(digits: 10).to_s }
    verifier_digit { Faker::Number.between(from: 0, to: 9).to_s }
    supplier
  end
end
