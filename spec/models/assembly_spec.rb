require 'rails_helper'

RSpec.describe Assembly, type: :model do
  it 'is valid all attributes' do
    assembly = create(:assembly)
    expect(assembly).to be_valid
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { should have_many(:assemblies_parts) }
  end
end
