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
  #To call this function: Account.create_account(params[:email],params[:password])
  def self.create_account(email,password)
    if Account.find_by(email: email)
      return 'taken'
    else
      account = Account.new(password:password,email:email)
      if account.save
        Mail.deliver do
          to email
          from 'contact.guildmasters@gmail.com'
          subject 'Subject - Thank You for signing up'
          body 'Click here to activate your account'
        end
        return 'success'
      else
        return 'error'
      end
    end
  end

  #This function logins with user specified email and password
  #returns result of the login and if it is successful, it will return the sessionid
  #To call this function: Account.login_account(params[:email],params[:password])
  def self.login_account(email,password)
    account = Account.find_by(email: email)
    if account and account.authenticate(password)
      # sessions[:account_id] = account.id
      return 'success'
      # return 'success' + sessions[:account_id]
    else
      return 'fail'
    end
  end
end
