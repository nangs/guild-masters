class Account < ActiveRecord::Base
  has_one :guildmaster
  has_secure_password
end
