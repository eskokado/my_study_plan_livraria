FactoryBot.define do
  factory :author do
    name { Faker::Name.name }
    cpf { CPF.generate }
  end
end
