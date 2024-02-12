# lib/tasks/email_tasks.rake

namespace :email do
  desc "Send email to contacts from a CSV file"
  task :send_to_csv, [:csv_file, :email_template_id] => :environment do |t, args|
    require 'csv'

    # Ensure arguments are provided
    if args[:csv_file].nil? || args[:email_template_id].nil?
      puts "Usage: rake email:send_to_csv[csv_file_path,email_template_id]"
      next
    end

    email_template_id = args[:email_template_id]
    receipt_number = Time.now.to_i # Example way to generate a unique receipt number

    CSV.foreach(args[:csv_file], headers: true) do |row|
      contact = Contact.upsert(row)

      if contact.present?
        # Enqueue the email to be sent
        EmailSenderWorker.perform_async(contact.id, email_template_id, receipt_number)
        puts "Enqueued email for: #{email}"
      else
        puts "Contact not found for email: #{email}"
      end
    end
  end
end
