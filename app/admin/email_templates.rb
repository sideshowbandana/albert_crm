ActiveAdmin.register EmailTemplate do
  menu if: proc{ current_admin_user.present? }

  filter :name
  filter :subject
  filter :body
  filter :created_at
  filter :updated_at

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :subject, :body
  #
  # or
  #
  permit_params do
    permitted = [:name, :subject, :body]
    #   permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end


  batch_action :bulk_email, confirm: "Are you sure you want to send this email template to all contacts?" do |ids|
    # Iterate over each selected email template
    counter = 0
    ids.each do |email_template_id|
      # Fetch each contact and queue the email sending job
      Contact.where.not(
        id: EmailReceipt.select(:contact_id).where(
          email_template_id: email_template_id
        )
      ).find_each do |contact|
        counter += 1
        EmailSenderWorker.perform_async(contact.id, email_template_id)
      end
    end

    # Redirect to the index page with a notice
    redirect_to collection_path, notice: "#{counter} emails are being sent to contacts."
  end

end
