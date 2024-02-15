class ChangeReceiptNumberToString < ActiveRecord::Migration[7.1]
def up
    enable_extension 'pgcrypto'

    # Assuming `receipt_number` was previously an integer or string
    # First, remove the column (or change its type directly if your DB supports it)
    remove_column :email_receipts, :receipt_number

    # Add the column back as a UUID
    add_column :email_receipts, :receipt_number, :uuid, default: 'gen_random_uuid()', null: false

    # Add a unique index on contact_id, email_template_id, and receipt_number
    add_index :email_receipts, [:contact_id, :email_template_id, :receipt_number], unique: true, name: 'index_email_receipts_on_contact_template_and_receipt'
  end

  def down
    # Remove the unique index
    remove_index :email_receipts, name: 'index_email_receipts_on_contact_template_and_receipt'

    # Change the column back to its original type
    remove_column :email_receipts, :receipt_number
    add_column :email_receipts, :receipt_number, :integer # Use the original type
  end
end
