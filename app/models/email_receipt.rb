class EmailReceipt < ApplicationRecord
  belongs_to :contact
  belongs_to :email_template

  def self.ransackable_attributes(auth_object = nil)
    ["contact_id", "created_at", "email_template_id", "id", "id_value", "receipt_number", "status", "updated_at"]
  end
end
