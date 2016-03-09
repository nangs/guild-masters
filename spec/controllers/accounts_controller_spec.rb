require 'rails_helper'

#rspec spec/controllers/accounts_controller_spec.rb --format documentation

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
        FactoryGirl.create(:account)
        get :index, :format => :json
        expect(Account.count).to eq(1)
        expect(response.header["Content-Type"]).to include "application/json"
      end
    end
    context "when params[:cmd] == activate_account" do
      before { post :create, { :params => { :cmd => "activate_account", :email => "testing@gmail.com", :confirm_token => "123456" }  } }
      it "activates account" do
        expect(response).to render_template("create")
        account = FactoryGirl.create(:account)
        expect(Account.count).to eq(1)
        expect(account.email_confirmed).to be false
        account.email_confirmed = true
        expect(account.email_confirmed).to be true
        get :index, :format => :json
        expect(Account.count).to eq(1)
        expect(response.header["Content-Type"]).to include "application/json"
      end
    end
    context "when params[:cmd] == update_account" do
      before { post :create, { :params => { :cmd => "update_account", :email => "testing@gmail.com", :password => "123456", :confirm_token => "123456" }  } }
      it "update account" do
        expect(response).to render_template("create")
        account = FactoryGirl.create(:account, :email_confirmed => true)
        expect(Account.count).to eq(1)
        expect(account.email_confirmed).to be true
        account.password = "123456"
        expect(account.password).to eq("123456")
        get :index, :format => :json
        expect(Account.count).to eq(1)
        expect(response.header["Content-Type"]).to include "application/json"
      end
    end
  end

end