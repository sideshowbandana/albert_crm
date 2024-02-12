ActiveAdmin.register Contact do

ActiveAdmin.register Contact do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :email, :address, :city, :state, :zip
  #
  # or
  #
  permit_params do
    permitted = [:name, :email, :address, :city, :state, :zip]
    # permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  collection_action :upload_csv, method: :post do
    # Logic to parse and process CSV file
    CsvProcessor.new(params[:csv_file]).process
    redirect_to collection_path, notice: "Contacts have been uploaded."
  end

  action_item :upload_csv, only: :index do
    link_to 'Upload CSV', action: 'upload_csv'
  end

  # Form to upload CSV
  collection_action :upload_csv, method: :get do
    render "admin/csv/upload_csv"
  end
end

end
