require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'is valid all attributes' do
    book = create(:book)
    expect(book).to be_valid
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:published_at) }
    it { is_expected.to validate_presence_of(:isbn) }
    it { is_expected.to belong_to :author }
  end
end
