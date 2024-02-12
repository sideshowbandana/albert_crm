class CreateEmailReceipts < ActiveRecord::Migration[7.1]
  def change
    create_table :email_receipts do |t|
      t.references :contact, null: false, foreign_key: true
      t.references :email_template, null: false, foreign_key: true
      t.string :status
      t.integer :receipt_number

      t.timestamps
    end
  end
end
