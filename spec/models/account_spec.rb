require 'rails_helper'

describe Account do
  it 'has a valid factor' do
    expect(FactoryGirl.create(:account)).to be_valid
  end
  it 'is invalid without password' do
    expect{ FactoryGirl.create(:account, password: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end
end