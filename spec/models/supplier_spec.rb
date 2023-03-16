require 'rails_helper'

RSpec.describe Supplier, type: :model do
  it 'is valid all attributes' do
    supplier = build(:supplier, cnpj: CNPJ.generate)
    expect(supplier).to be_valid
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { should have_one(:account) }
  end
end
