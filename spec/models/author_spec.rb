require 'rails_helper'

RSpec.describe Author, type: :model do
  it 'is valid all attributes' do
    author = build(:author, cpf: CPF.generate)
    expect(author).to be_valid
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:cpf) }
    it { should have_many(:books) }
  end
end
