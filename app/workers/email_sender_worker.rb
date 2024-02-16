require 'erb'

class EmailSenderWorker
  include Sidekiq::Worker

  EXPONENTIAL_BACKOFF_BASE = 5

  def perform(contact_id, email_template_id, backoff_exponent = 0)
    backoff_exponent = backoff_exponent.to_i
    begin
      contact = Contact.find(contact_id)
      email_template = EmailTemplate.find(email_template_id)
      # Check if the contact has a 'bounced' status for any email, skip sending
      return if EmailReceipt.where(contact_id: contact_id, status: 'bounced').exists?

      # Check if the contact has already received an email for this template and receipt number
      return if EmailReceipt.exists?(contact_id: contact_id, email_template: email_template_id, status: EmailClient::EmailStatus::DELIVERED)

      rendered_subject = render_erb(email_template.subject, contact)
      rendered_body = render_erb(email_template.body, contact)

      # Simulate sending an email
      response = send_email(contact.email, rendered_subject, rendered_body)

      # Record the email attempt with its status
      EmailReceipt.create!(
        contact_id: contact_id,
        email_template_id: email_template_id,
        receipt_number: response[:id],
        status: response[:status]
      )

      if response[:status] == EmailClient::EmailStatus::BOUNCED && backoff_exponent < 3
        backoff_exponent += 1
        EmailSenderWorker.perform_in(EXPONENTIAL_BACKOFF_BASE**backoff_exponent, contact_id, email_template_id, backoff_exponent)
      end
    rescue => e
      Rails.logger.error("Unable to send email contact_id: #{contact_id} email_template_id: #{email_template_id}")
      Rails.logger.error(e.message)
      e.backtrace.each do |line|
        Rails.logger.error("    #{line}")
      end
    end
  end

  private

  def render_erb(template, contact)
    ERB.new(template).result_with_hash(name: contact.name).gsub("\n", "<br>").html_safe
  end

  def send_email(email, subject, body)
    # Simulated logic for sending an email
    client = EmailClient.new
    client.send_email(subject, body, email)
  end
end
