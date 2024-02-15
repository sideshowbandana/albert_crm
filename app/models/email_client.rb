require 'securerandom'

class EmailClient
  # Mock email client for testing purposes.

  module EmailStatus
    # Status of an email.
    SENT = "sent"
    DELIVERED = "delivered"
    BOUNCED = "bounced"
    BLOCKED = "blocked"
  end

  def send_email(subject, body, to)
    # Send an email asynchronously.
    email_id = SecureRandom.uuid
    puts "Email sent, to=#{to} subject=#{subject} body=#{body} email_id=#{email_id}"
    {
      id: email_id,
      status: generate_status
    }
  end

  private
  def generate_status
    # Get the status of an email.
    # ~10% of messages hold for a short time
    sleep(1 + rand * 4) if rand < 0.1

    # Randomly select the email status.
    # ~80% of messages are delivered, ~10% of messages are bounced, ~10% are blocked
    return ([EmailStatus::DELIVERED] * 8 + [EmailStatus::BOUNCED] + [EmailStatus::BLOCKED]).sample
  end
end
