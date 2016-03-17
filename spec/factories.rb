require 'faker'

FactoryGirl.define do
  factory :account do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirm_token { Faker::Number.number(4) }
    email_confirmed { false }
    id { Faker::Number.number(4) }
    guildmaster
  end

  factory :guildmaster do
    id { Faker::Number.number(4) }
    gold 1000
    game_time 0
    state "available"
    account_id :account.object_id
    current_guild_id 0
  end

  factory :guilds do
    id { Faker::Number.number(4) }
    level { Faker::Number.between(1, 3) }
    popularity { Faker::Number.number(2) }
    guildmaster_id :guildmaster.object_id
  end
end
