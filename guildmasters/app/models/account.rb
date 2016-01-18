class Account < ActiveRecord::Base
  has_one :guildmaster, dependent: :destroy
  has_secure_password
  def self.generate(username,password,email)
    account = Account.new(username:username,password:password,email:email)
    if account.save
      return 'Account was successfully created.'
    else
      return 'Error creating account'
    end
  end
end
