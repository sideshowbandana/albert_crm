ActiveAdmin.register EmailTemplate do

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

  member_action :send_emails, method: :post do
    email_template = EmailTemplate.find(params[:id])
    Contact.find_each do |contact|
      # Ensure no duplicate job is queued for the same contact with the same email template and receipt number
      unless EmailReceipt.exists?(contact: contact, email_template: email_template, receipt_number: some_logic_to_define_receipt_number)
        EmailSenderWorker.perform_async(contact.id, email_template.id, some_logic_to_define_receipt_number)
      end
    end
    redirect_to resource_path(email_template), notice: "Emails are being sent."
  end

  action_item :send_emails, only: :show do
    link_to 'Send Emails', action: 'send_emails', method: :post
  end

end
