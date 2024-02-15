require 'rails_helper'

RSpec.describe EmailSenderWorker, type: :model do
  #   - Each contact should receive at most one email, including cases where the same contact is listed multiple times in a .csv or is included in 2 or more .csv files.

# - Emails to contacts that are `bounced` should be treated as permanent failures and should not be retried.
# - Emails to contacts that are `blocked` should be treated as temporary failures and should be retried by sending a new email.

  let!(:email_receipt) do
    FactoryBot.create(:email_receipt, options)
  end

  context "when an email has already been delieverd" do
    let(:options) do
      { status: EmailClient::EmailStatus::DELIVERED }
    end
    it "wont send again" do
      expect{
        subject.perform(email_receipt.contact_id, email_receipt.email_template_id)
      }.not_to change{
        EmailReceipt.count
      }
    end
  end

  context "when an email has bounced" do
    let(:options) do
      { status: EmailClient::EmailStatus::BOUNCED }
    end
    it "wont send again" do
      expect{
        subject.perform(email_receipt.contact_id, email_receipt.email_template_id)
      }.not_to change{
        EmailReceipt.count
      }
    end
  end

  context "when an email has blocked" do
    let(:options) do
      { status: EmailClient::EmailStatus::BLOCKED }
    end
    it "will send again" do
      expect{
        subject.perform(email_receipt.contact_id, email_receipt.email_template_id)
      }.to change{
        EmailReceipt.count
      }
    end
  end
end
