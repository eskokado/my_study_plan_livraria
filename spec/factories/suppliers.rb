FactoryBot.define do
  factory :supplier do
    name { Faker::Company.name }
    cnpj { CNPJ.generate }
  end
end
