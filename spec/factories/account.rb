require 'faker'

FactoryGirl.define do
  factory :account do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirm_token { Faker::Number.number(4) }
    email_confirmed { false }
  end
end