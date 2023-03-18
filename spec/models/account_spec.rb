require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'is valid all attributes' do
    account = create(:account)
    expect(account).to be_valid
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:account_number) }
    it { is_expected.to validate_presence_of(:verifier_digit) }
    it { is_expected.to belong_to :supplier }
  end
end
