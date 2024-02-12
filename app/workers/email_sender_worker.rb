# app/workers/email_sender_worker.rb
class EmailSenderWorker
  include Sidekiq::Worker

  def perform(contact_id, email_template_id, receipt_number)
    contact = Contact.find(contact_id)
    email_template = EmailTemplate.find(email_template_id)

    rendered_subject = render_erb(email_template.subject, contact)
    rendered_body = render_erb(email_template.body, contact)

    # Implement your email sending logic here
    # For example, sending an email with the rendered subject and body
    send_email(contact.email, rendered_subject, rendered_body)

    EmailReceipt.create!(
      contact_id: contact_id,
      email_template_id: email_template_id,
      receipt_number: receipt_number,
      status: 'pending'
    )
  end

  private

  def render_erb(template, contact)
    ERB.new(template).result_with_hash(name: contact.name)
  end

  def send_email(email, subject, body)
    # Placeholder for email sending logic
    puts "Sending email to: #{email} with subject: '#{subject}' and body: '#{body}'"
  end
end
