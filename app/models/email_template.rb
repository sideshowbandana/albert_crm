class EmailTemplate < ApplicationRecord
  has_many :email_receipts, dependent: :destroy

  validates :name, presence: true
  validates :subject, presence: true
  validates :body, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "id_value", "name", "subject", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["email_receipts"]
  end
end
