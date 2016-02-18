require 'rails_helper'

describe AccountsController do
  describe "GET #index" do
    it "populates an array of accounts" do
      expect(Account.count).to eq(0)
      account = FactoryGirl.create(:account)
      get :index, :format => :json
      expect(Account.count).to eq(1)
    end
 end
end