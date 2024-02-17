ActiveAdmin.register EmailReceipt do
  menu if: proc{ current_admin_user.present? }

  actions :all, except: [:new]

  # Customizing the index table
  index do
    selectable_column
    id_column
    column :contact_id do |receipt|
      link_to(receipt.contact_id, admin_contact_path(receipt.contact_id))
    end
    column :email_template_id do |receipt|
      link_to(receipt.email_template_id, admin_email_template_path(receipt.email_template_id))
    end
    column :status
    column :receipt_number
    column :created_at
    actions
  end

  # Filters
  filter :contact_id
  filter :email_template_id
  filter :status
  filter :receipt_number
  filter :created_at

  # Form customization (if necessary)
  form do |f|
    f.inputs do
      f.input :status
      f.input :receipt_number
    end
    f.actions
  end

  # Permitting parameters
  permit_params :status, :receipt_number
end
