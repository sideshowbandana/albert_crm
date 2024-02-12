# app/workers/email_sender_worker.rb
class EmailSenderWorker
  include Sidekiq::Worker

  def perform(contact_id, email_template_id, receipt_number)
    contact = Contact.find(contact_id)
    email_template = EmailTemplate.find(email_template_id)

    # Example sending email logic (implement your email sending mechanism here)
    # For example, using ActionMailer:
    # MyMailer.send_email(contact.email, email_template).deliver_now

    # Log the email sending attempt
    EmailReceipt.create!(
      contact_id: contact_id,
      email_template_id: email_template_id,
      receipt_number: receipt_number,
      status: 'sent' # or 'failed', based on the outcome of the sending process
    )
  rescue StandardError => e
    # Handle error, possibly updating the EmailReceipt with a 'failed' status
    puts "Email sending failed: #{e.message}"
  end
end
