class Account < ActiveRecord::Base
  has_one :guildmaster, dependent: :destroy
  has_secure_password
end
