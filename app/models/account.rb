class Account < ActiveRecord::Base
  require 'mail'
  has_one :guildmaster, dependent: :destroy
  has_secure_password

  options = {
      :address              => 'smtp.gmail.com',
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
    if email.nil?
      return {msg: "error", detail: "email_nil"}
    end
    if password.nil?
      return {msg: "error", detail: "password_nil"}
    end
    account = Account.find_by(email: email)
    if !account.nil?
      if account.email_confirmed
        return {msg: "error", detail: "account_taken"}
      elsif !account.email_confirmed
        return {msg: "error", detail: "not_activated"}
      else
        return {msg: "error", detail: "unknown"}
      end
    elsif account.nil?
      account = Account.new(password:password,email:email)
      if account.save
        account.confirm_token = account.id * rand(999)
        account.save
        account.initialize_guildmaster
        return {msg: "success"}
      else
        return {msg: "error", detail: "creating_account"}
      end
    end
  end

  def self.resend_email(email)
    account = Account.find_by(email: email)
    if !account.nil? && !account.email_confirmed
      account.confirm_token = account.id * rand(999)
      account.save
      return {msg: "success"}
    elsif account.nil
      return {msg: "error", detail: "invalid_account"}
    elsif account.email_confirmed
      return {msg: "error", detail: "already_activated"}
    else
      return {msg: "error", detail: "unknown"}
    end
  end

  def self.send_password_token(email)
    account = Account.find_by(email: email)
    if !account.nil?
      account.confirm_token = account.id * rand(999)
      account.save
      return {msg: "success"}
    end
  end

  def self.activate_account(email,confirm_token)
    account = Account.find_by(email: email)
    if !account.nil? && account.confirm_token == confirm_token
      account.email_confirmed = true
      account.save
      return {msg: "success"}
    elsif account.nil?
      return {msg: "error", detail: "invalid_account"}
    elsif account.email_confirmed
      return {msg: "error", detail: "already_activated"}
    elsif account.confirm_token != confirm_token
      return {msg: "error", detail: "wrong_token"}
    end
  end

  def self.update_account(email,password,confirm_token)
    account = Account.find_by(email: email)
    if !account.nil? && account.confirm_token == confirm_token
      account.password = password
      account.email_confirmed = true
      account.save
      return {msg: "success"}
    elsif account.confirm_token != confirm_token
      return {msg: "error", detail: "wrong_token"}
    elsif account.nil
      return {msg: "error", detail: "invalid_account"}
    else
      return {msg: "error", detail: "unknown"}
    end
  end

  def self.send_email(email,type)
    account = Account.find_by(email: email)
    if type == 'signup'
      subject = 'Subject - Thank You for signing up'
      body = "Please activate your account with the code provided:\nActivation Code: #{ account.confirm_token }"
    elsif type == 'reset_password'
      if !account.email_confirmed
        subject = 'Subject - Password Change and Account Activation'
        body = "Please change your account password and activate your account with the code provided:\nCode: #{ account.confirm_token }"
      elsif account.email_confirmed
        subject = 'Subject - Password Change'
        body = "Please change your account password with the code provided:\nCode: #{ account.confirm_token }"
      end
    end
    Mail.deliver do
      to email
      from 'contact.guildmasters@gmail.com'
      subject subject
      body body
    end
  end

  def initialize_guildmaster
    gm = Guildmaster.new
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
