class EmailSender
  require 'mail'

  options = {
    address: 'smtp.gmail.com',
    port: 587,
    user_name: Rails.application.secrets.email_sender_user_name,
    password: Rails.application.secrets.email_sender_password,
    authentication: 'plain',
    enable_starttls_auto: true
  }
  Mail.defaults do
    delivery_method :smtp, options
  end

  def self.send_email(email, email_type)
    account = Account.find_by(email: email)
    if email_type == :signup && !account.nil?
      subject = 'Thank You for signing up with GuildMasters'
      body = "Please activate your account with the code provided:\nActivation Code: #{account.confirm_token}"
    elsif email_type == :reset_password
      if !account.email_confirmed && !account.nil?
        subject = 'GuildMasters - Password Change and Account Activation'
        body = "Please change your account password and activate your account with the code provided:\nCode: #{account.confirm_token}"
      elsif account.email_confirmed && !account.nil?
        subject = 'GuildMasters - Password Change'
        body = "Please change your account password with the code provided:\nCode: #{account.confirm_token}"
      end
    end
    Mail.deliver do
      to email
      from :user_name
      subject subject
      body body
    end
  end
end
