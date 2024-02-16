# lib/tasks/email_tasks.rake

namespace :email do
  desc "Send email to contacts from a CSV file"
  task send_to_csv: :environment do
    require 'csv'
    csv_file = "input.csv"
    template_name = ENV["EMAIL_TEMPLATE_NAME"]
    async = ENV["ASYNC"]

    # Ensure arguments are provided
    if csv_file.blank? || template_name.blank?
      puts "Usage: CSV_FILE=file_path EMAIL_TEMPLATE_NAME=welcome rake email:send_to_csv"
      next
    end

    unless email_template_id = EmailTemplate.find_by(name: template_name)&.id
      puts "No Email Template Named: #{template_name}"
      next
    end

    CsvProcessor.new(csv_file).process.each do |contact|
      if async
        EmailSenderWorker.perform_async(contact["id"], email_template_id, SecureRandom.uuid)
      else
        EmailSenderWorker.new.perform(contact["id"], email_template_id, SecureRandom.uuid)
      end
    end
  end
end
