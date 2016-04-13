require 'rails_helper'
# rspec spec/models/guild_spec.rb

RSpec.describe Guild do
  it 'has a valid factor' do
    expect(FactoryGirl.build(:guild)).to be_valid
  end
end
