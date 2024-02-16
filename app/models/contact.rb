class Contact < ApplicationRecord
  has_many :email_receipts
  validates_presence_of :email

  def self.ransackable_attributes(auth_object = nil)
    ["address", "city", "created_at", "email", "id", "id_value", "name", "state", "phone_number", "updated_at", "zip"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["email_receipts"]
  end
end
