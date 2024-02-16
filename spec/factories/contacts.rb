FactoryBot.define do
  factory :contact do
    name { "John Doe" }
    email { "john.doe@example.com" }
    address { "123 Main St" }
    city { "Anytown" }
    state { "Anystate" }
    zip { "12345" }
  end
end
