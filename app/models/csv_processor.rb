class CsvProcessor
  require 'csv'

  def initialize(file)
    @file = file
  end

  def call
    CSV.foreach(@file.path, headers: true) do |row|
      Contact.upsert(row.to_hash)
    end
  end
end
