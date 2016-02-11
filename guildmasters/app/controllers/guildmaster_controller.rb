class GuildmasterController < ApplicationController
  # GET /guildmaster.json

  ########
  ########for testing not for release
  ########
  def index
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    respond_to do |format|
      format.json { render json: guildmaster }
    end
  end
  ########
  ########for testing not for release
  ########

  def create
  end

  def show
  end
end

