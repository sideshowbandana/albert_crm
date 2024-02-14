class EmailTemplate < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "id_value", "name", "subject", "updated_at"]
  end
end
