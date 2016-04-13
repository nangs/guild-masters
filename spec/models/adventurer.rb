require 'rails_helper'
# rspec spec/models/adventurer_spec.rb

RSpec.describe Adventurer do
  it 'has a valid factor' do
    expect(FactoryGirl.build(:adventurer)).to be_valid
  end
end
