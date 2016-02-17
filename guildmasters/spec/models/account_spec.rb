require 'rails_helper'

describe Account do
  it "has a valid factory" do
    expect(FactoryGirl.create(:account)).to be_valid
  end
  it "is invalid without email"
  it "is invalid without password"
end