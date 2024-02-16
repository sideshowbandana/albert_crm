require 'rails_helper'

RSpec.describe EmailTemplate, type: :model do
  # Validations
  describe 'validations' do
    it 'is valid with valid attributes' do
      email_template = build(:email_template)
      expect(email_template).to be_valid
    end

    it 'is not valid without a name' do
      email_template = build(:email_template, name: nil)
      expect(email_template).not_to be_valid
    end

    it 'is not valid without a subject' do
      email_template = build(:email_template, subject: nil)
      expect(email_template).not_to be_valid
    end

    it 'is not valid without a body' do
      email_template = build(:email_template, body: nil)
      expect(email_template).not_to be_valid
    end
  end
end
