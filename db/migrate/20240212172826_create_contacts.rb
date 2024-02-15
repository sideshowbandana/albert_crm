class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
    add_index :contacts, :email, unique: true
    add_index :contacts, :address
    add_index :contacts, :name
    add_index :contacts, :city
    add_index :contacts, :state
    add_index :contacts, :zip
  end
end
