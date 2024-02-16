ActiveAdmin.register Contact do
  menu if: proc{ current_admin_user.present? }
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :email, :address, :city, :state, :zip
  #
  # or
  #
  permit_params :name, :email, :address, :city, :state, :zip, :phone_number

  filter :name
  filter :email
  filter :address
  filter :city
  filter :state
  filter :zip
  filter :created_at
  filter :updated_at

  # POST action for processing the uploaded CSV
  collection_action :import_csv, method: :post do
    uploaded_io = params.require(:contact).require(:csv_file)
    # Construct the path with the shared volume directory
    file_path = File.join(Rails.root, "tmp", "storage", "user_data", "#{SecureRandom.uuid}.csv")

    # Ensure the 'uploads' directory exists
    FileUtils.mkdir_p(File.dirname(file_path))

    # Write the uploaded file to the shared volume
    File.open(file_path, 'wb') do |file|
      file.write(uploaded_io.read)
    end

    # Enqueue the worker with the path to the saved file
    CsvProcessorWorker.perform_async(file_path)

    redirect_to collection_path, notice: "Contacts upload has been enqueued."
  end

  # GET action to display the form for uploading CSV
  collection_action :upload_csv, method: :get do
    render "admin/csv/upload_csv"
  end

  # Action item to navigate to the CSV upload form
  action_item :upload_csv, only: :index do
    link_to 'Upload CSV', action: 'upload_csv'
  end

  # Batch action for sending emails
  batch_action :email, form: -> {
    # Assuming you have EmailTemplate records. Fetch them for the dropdown.
    {
      email_template: EmailTemplate.pluck(:name, :id)
    }
  } do |ids, inputs|
    # `ids` holds the IDs of selected contacts
    # `inputs` contains the form inputs, including selected email_template

    # Fetch the selected EmailTemplate
    email_template_id = inputs[:email_template]

    # Queue a job for each selected contact
    ids.each do |id|
      EmailSenderWorker.perform_async(id, email_template_id)
    end

    # Redirect to the Contacts index page with a notice
    redirect_to collection_path, notice: "#{ids.size} emails are being sent."
  end

  # Ensure strong parameters are set up correctly
  permit_params do
    permitted = [:name, :email, :address, :city, :state, :zip]
    permitted
  end
end
