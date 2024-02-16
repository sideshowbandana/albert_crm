class AddCascadeDeleteEmailReceipts < ActiveRecord::Migration[7.1]
  def up
    # Remove the existing foreign key constraints
    remove_foreign_key :email_receipts, :contacts
    remove_foreign_key :email_receipts, :email_templates

    # Add them back with the cascade delete option
    add_foreign_key :email_receipts, :contacts, on_delete: :cascade
    add_foreign_key :email_receipts, :email_templates, on_delete: :cascade
  end

  def down
    # Remove the cascade delete foreign keys
    remove_foreign_key :email_receipts, :contacts
    remove_foreign_key :email_receipts, :email_templates

    # Add back the original constraints without cascade delete
    add_foreign_key :email_receipts, :contacts
    add_foreign_key :email_receipts, :email_templates
  end
end
