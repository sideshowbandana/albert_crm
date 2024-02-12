FactoryBot.define do
  factory :email_receipt do
    contact { nil }
    email_template { nil }
    status { "MyString" }
    receipt_number { 1 }
  end
end
