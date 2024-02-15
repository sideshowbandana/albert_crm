ActiveAdmin.register EmailReceipt do
  menu if: proc{ current_admin_user.present? }

  # Customizing the index table
  index do
    selectable_column
    id_column
    column :contact_id
    column :email_template_id
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
