FactoryBot.define do
  factory :account do
    account_number { "000010009795493"}
    verifier_digit { "97" }
    supplier
  end
end
