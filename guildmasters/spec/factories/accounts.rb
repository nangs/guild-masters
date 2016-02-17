require 'faker'

FactoryGirl.define do
  factory :account do |f|
    f.email { Faker::Internet.email }
    f.password { Faker::Internet.password }
  end
end