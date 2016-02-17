require 'rails_helper'

describe AccountsController do
  describe "GET #index" do
    it "populates an array of accounts" do
      account = FactoryGirl.create(:account)
      get :index
      assigns(:accounts).should eq([account])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested account to @account" do
      account = Factory(:account)
      get :show, id: account
      assigns(:account).should eq(account)
    end

    it "renders the #show view" do
      get :show, id: Factory(:account)
      response.should render_template :show
    end
  end
end