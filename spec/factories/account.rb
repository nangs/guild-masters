require 'faker'

FactoryGirl.define do
  factory :account do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirm_token { Faker::Name.name}
    email_confirmed { false }
  end
end