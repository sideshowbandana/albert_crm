FactoryBot.define do
  factory :email_template do
    name { "Welcome Email" }
    subject { "Welcome to Our Service!" }
    body { "This is the body of the email." }
  end
end
