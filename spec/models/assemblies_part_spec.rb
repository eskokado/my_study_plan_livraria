require 'rails_helper'

RSpec.describe AssembliesPart, type: :model do
  it 'is valid all attributes' do
    assembliesPart = create(:assemblies_part)
    expect(assembliesPart).to be_valid
  end

  context 'Validations' do
    it { is_expected.to belong_to :assembly }
    it { is_expected.to belong_to :part }
  end
end
