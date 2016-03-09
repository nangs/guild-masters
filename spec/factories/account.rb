require 'faker'

FactoryGirl.define do
  factory :account do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirm_token { Faker::Number.between(1, 10)}
    email_confirmed { false }
  end
end