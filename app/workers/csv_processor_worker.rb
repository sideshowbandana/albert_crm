class CsvProcessorWorker
  include Sidekiq::Worker

  def perform(csv_file_path)
    CsvProcessor.new(csv_file_path).process
  end
end
