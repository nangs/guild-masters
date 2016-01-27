class Account < ActiveRecord::Base
  has_one :guildmaster, dependent: :destroy
  has_secure_password

  #This function creates an account with user specified email and password
  #returns result of the creation
  def self.generate(email,password)
    if Account.find_by(email: email)
      return 'Taken'
    else
      account = Account.new(password:password,email:email)
      if account.save
        return 'Success'
      else
        return 'Error'
      end
    end
  end
end
# account = Account.generate(params[:email],params[:password])
