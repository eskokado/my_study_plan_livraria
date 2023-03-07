require 'rails_helper'

RSpec.describe Author, type: :model do
  it 'is valid all attributes' do
    author = create(:author)
    expect(author).to be_valid
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { should have_many(:books) }
  end
end
