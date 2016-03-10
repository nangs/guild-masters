require 'rails_helper'
#rspec spec/models/account_spec.rb --format documentation

describe Account do
  it 'has a valid factor' do
    expect(Account.count).to eq(0)
    expect(FactoryGirl.create(:account)).to be_valid
    expect(Account.count).to eq(1)
  end
  it 'has a valid factor without email' do
    expect(Account.count).to eq(0)
    expect(FactoryGirl.create(:account, email: nil)).to be_valid
    expect(Account.count).to eq(1)
  end
  it 'is invalid without password' do
    expect(Account.count).to eq(0)
    expect{ FactoryGirl.create(:account, password: nil) }.to raise_error(ActiveRecord::RecordInvalid)
    expect(Account.count).to eq(0)
  end
end