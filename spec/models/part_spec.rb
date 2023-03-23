require 'rails_helper'

RSpec.describe Part, type: :model do
  it 'is valid all attributes' do
    part = create(:part)
    expect(part).to be_valid
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:part_number) }
    it { is_expected.to validate_presence_of(:value) }
    it { should have_many(:assemblies_parts) }
  end
end
