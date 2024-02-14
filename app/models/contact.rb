class Contact < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["address", "city", "created_at", "email", "id", "id_value", "name", "state", "updated_at", "zip"]
  end
end
