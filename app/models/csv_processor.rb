class CsvProcessor
  require 'csv'

  HEADERS=[:name, :email, :phone_number, :address, :city, :state, :zip]

  def initialize(file_path)
    @file_path = file_path
  end

  def process
    data = {  }
    CSV.foreach(@file_path) do |row|
      attributes = Hash[HEADERS.zip(row)]
      # if the csv has duplicates, take the last one.
      data[attributes[:email]] = attributes
    end
    # if we have a duplicate, update it.
    Contact.upsert_all(data.values, unique_by: :email, on_duplicate: :update)
  end
end
