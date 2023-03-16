require 'rails_helper'

RSpec.describe AssembliesBook, type: :model do
  it 'is valid all attributes' do
    assembliesBook = create(:assemblies_book)
    expect(assembliesBook).to be_valid
  end

  context 'Validations' do
    it { is_expected.to belong_to :book }
    it { is_expected.to belong_to :assembly }
  end
end
