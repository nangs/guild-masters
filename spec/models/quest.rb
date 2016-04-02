require 'rails_helper'
#rspec spec/models/quest_spec.rb

RSpec.describe Quest do
  it 'has a valid factor' do
    expect(FactoryGirl.build(:quest)).to be_valid
  end
end