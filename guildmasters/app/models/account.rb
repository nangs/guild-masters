class Account < ActiveRecord::Base
  require 'mail'
  has_one :guildmaster, dependent: :destroy
  has_secure_password

  options = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :user_name            => 'contact.guildmasters@gmail.com',
      :password             => 'guildmasters12345',
      :authentication       => 'plain',
      :enable_starttls_auto => true
  }
  Mail.defaults do
    delivery_method :smtp, options
  end

  #This function creates an account with user specified email and password
  #returns result of the creation
  #email created and activated
  #email created but not activated
  #email does not exist
  #To call this function: Account.create_account(params[:email],params[:password])
  def self.create_account(email,password)
    account = Account.find_by(email: email)
    if !account.nil?
      if account.email_confirmed
        return 'taken'
      elsif !account.email_confirmed
        return 'not_activated'
      end
    else
      account = Account.new(password:password,email:email)
      if account.save
        send_mail(email,account)
      end
    end
  end

  def self.activate_account(email,confirm_token)
    account = Account.find_by(email: email)
    if !account.nil? && account.confirm_token == confirm_token
      account.email_confirmed = true
      account.save
      return 'success'
    else
      return 'fail'
    end
  end

  def send_mail(email,account)
    account.confirm_token = account.id * rand(999)
    account.save
    Mail.deliver do
      to email
      from 'contact.guildmasters@gmail.com'
      subject 'Subject - Thank You for signing up'
      body "Please activate your account with the code provided:\nActivation Code: #{account.confirm_token}"
    end
    account.initialize_guildmaster
    return 'success'
  else
    return 'error'
  end

  def initialize_guildmaster
    gm=Guildmaster.new
    gm.gold = 1000
    gm.game_time = 0
    gm.state = 'available'
    gm.account = self
    gm.save
    gm.build_guild
  end

  def gm_info
    return self.guildmaster
  end
end
