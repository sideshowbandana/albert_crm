require 'rails_helper'

RSpec.describe EmailReceipt, type: :model do
  # Validations
  describe "validations" do
    it "is valid with valid attributes" do
      email_receipt = build(:email_receipt)
      expect(email_receipt).to be_valid
    end

    it "is not valid without a status" do
      email_receipt = build(:email_receipt, status: nil)
      expect(email_receipt).not_to be_valid
    end

    it "is not valid without a receipt_number" do
      email_receipt = build(:email_receipt, receipt_number: nil)
      expect(email_receipt).not_to be_valid
    end
  end

  # Associations
  describe "associations" do
    it { should belong_to(:contact) }
    it { should belong_to(:email_template) }
  end
end
