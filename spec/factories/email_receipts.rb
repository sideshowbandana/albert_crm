FactoryBot.define do
  factory :email_receipt do
    contact
    email_template
    status { EmailClient::EmailStatus::SENT }
    receipt_number { nil }
  end
end
