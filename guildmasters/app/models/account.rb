class Account < ActiveRecord::Base
  has_one :guildmaster, dependent: :destroy
  has_secure_password

  #This function creates an account with user specified email and password
  #returns result of the creation
  def self.generate(email,password)
    account = Account.new(password:password,email:email)
    if account.save
      return 'Account was successfully created.'
    else
      return 'Error creating account'
    end
  end
end
