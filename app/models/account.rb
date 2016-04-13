class Account < ActiveRecord::Base
  require 'thread'
  $semaphore = Mutex.new
  has_one :guildmaster, dependent: :destroy
  has_secure_password

  # This function creates an account with user specified email and password
  # returns result of the creation
  # email created and activated
  # email created but not activated
  # email does not exist
  # To call this function: Account.create_account(params[:email],params[:password])
  def self.create_account(email, password)
    account = Account.find_by(email: email)
    if !account.nil?
      return { msg: :error, detail: :account_taken } if account.email_confirmed
      { msg: :error, detail: :not_activated }
    elsif account.nil?
      new_account = Account.new(password: password, email: email)
      new_account.save
      new_account.confirm_token = new_account.id * rand(999)
      new_account.save
      new_account.initialize_guildmaster
      thr = Thread.new do
        $semaphore.synchronize do
          EmailSender.send_email(email, :signup)
        end
      end
      thr.join(0)
      return { msg: :success }
    end
  end

  def self.resend_email(email)
    account = Account.find_by(email: email)
    if !account.nil? && !account.email_confirmed
      account.confirm_token = account.id * rand(999)
      account.save
      thr = Thread.new do
        $semaphore.synchronize do
          EmailSender.send_email(email, :signup)
        end
      end
      thr.join(0)
      return { msg: :success }
    elsif account.nil?
      return { msg: :error, detail: :invalid_account }
    elsif account.email_confirmed
      return { msg: :error, detail: :already_activated }
    end
  end

  def self.send_password_token(email)
    account = Account.find_by(email: email)
    if !account.nil?
      account.confirm_token = account.id * rand(999)
      account.save
      thr = Thread.new do
        $semaphore.synchronize do
          EmailSender.send_email(email, :reset_password)
        end
      end
      thr.join(0)
      return { msg: :success }
    elsif account.nil?
      return { msg: :error, detail: :invalid_account }
    end
  end

  def self.activate_account(email, confirm_token)
    account = Account.find_by(email: email)
    if !account.nil? && account.confirm_token == confirm_token && !account.email_confirmed
      account.email_confirmed = true
      account.save
      return { msg: :success }
    elsif account.nil?
      return { msg: :error, detail: :invalid_account }
    elsif account.email_confirmed
      return { msg: :error, detail: :already_activated }
    elsif account.confirm_token != confirm_token
      return { msg: :error, detail: :wrong_token }
    end
  end

  def self.update_account(email, password, confirm_token)
    account = Account.find_by(email: email)
    if !account.nil? && account.confirm_token == confirm_token
      account.password = password
      account.email_confirmed = true
      account.save
      return { msg: :success }
    elsif !account.nil? && account.confirm_token != confirm_token
      return { msg: :error, detail: :wrong_token }
    elsif account.nil?
      return { msg: :error, detail: :invalid_account }
    end
  end

  def initialize_guildmaster
    gm = Guildmaster.new
    gm.gold = 1000
    gm.game_time = 0
    gm.state = :available
    gm.account = self
    gm.save
    gm.build_guild
  end

  def gm_info
    guildmaster
  end
end
