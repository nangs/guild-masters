require 'rails_helper'
# rspec spec/models/guildmaster_spec.rb

RSpec.describe Guildmaster do
  it 'has a valid factor' do
    expect(FactoryGirl.build(:guildmaster)).to be_valid
  end
end
