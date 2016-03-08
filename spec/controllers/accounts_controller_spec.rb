require 'rails_helper'

describe AccountsController do
  describe "GET #index" do
    it "populates an array of accounts" do
      expect(Account.count).to eq(0)
      FactoryGirl.create(:account)
      get :index, :format => :json
      expect(Account.count).to eq(1)
    end
  end

  describe "POST #create" do
    context "when params[:cmd] == signup" do
      before { post :create, { :params => { :cmd => "signup", :email => "testing@gmail.com", :password => "123456" }  } }
      it "creates account" do
        expect(response).to render_template("create")
        expect(Account.count).to eq(0)
        FactoryGirl.create(:account, email: "testing@gmail.com", password: "123456")
        get :index, :format => :json
        expect(Account.count).to eq(1)
        expect(response.header["Content-Type"]).to include "application/json"
      end
    end
  end

end