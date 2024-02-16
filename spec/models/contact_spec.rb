require 'rails_helper'

RSpec.describe Contact, type: :model do
  # Validations
  describe 'validations' do
    it 'is valid with valid attributes' do
      contact = FactoryBot.build(:contact)
      expect(contact).to be_valid
    end

    it 'is not valid without a name' do
      contact = FactoryBot.build(:contact, name: nil)
      expect(contact).not_to be_valid
    end

    it 'is not valid without an email' do
      contact = FactoryBot.build(:contact, email: nil)
      expect(contact).not_to be_valid
    end

    it 'is not valid without a unique email' do
      FactoryBot.create(:contact, email: 'test@example.com')
      contact = FactoryBot.build(:contact, email: 'test@example.com')
      expect(contact).not_to be_valid
    end
  end

  # Associations
  describe 'associations' do
    it { should have_many(:email_receipts).dependent(:destroy) }
  end
end
