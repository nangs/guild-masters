require 'faker'

FactoryGirl.define do
  factory :account do
    id { Faker::Number.number(4) }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirm_token { Faker::Number.number(4) }
    email_confirmed { false }
    trait :activated do
      email_confirmed true
    end
  end

  factory :guildmaster do
    id { Faker::Number.number(4) }
    gold 1000
    game_time 0
    state "available"
    current_guild_id 0
    account_id :account.__id__
    association :account, factory: :account, email_confirmed: true
  end

  factory :guild do
    id { Faker::Number.number(4) }
    level { Faker::Number.between(1, 3) }
    popularity { Faker::Number.number(2) }
    guildmaster_id :guildmaster.__id__
    guildmaster
  end
end
