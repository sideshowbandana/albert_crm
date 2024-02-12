class EmailReceipt < ApplicationRecord
  belongs_to :contact
  belongs_to :email_template
end
