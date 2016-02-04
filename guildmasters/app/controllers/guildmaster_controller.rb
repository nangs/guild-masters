class GuildmasterController < ApplicationController
  # GET /guildmaster.json
  def index
    @guildmaster = Guildmaster.get_info
    respond_to do |format|
      #format.html # index.html.erb
      format.json { render json: @guildmaster }
    end
  end

  def create
    gmId = params[:id]
    @guildmaster = Account.find_by(gmId).guildmaster
    respond_to do |format|
      #format.html # index.html.erb
      format.json { render json: @guildmaster }
    end
  end

  def show
    acc = Account.find(params[:id])
    gm = acc.guildmaster
    respond_to do |format|
      format.json { render json: gm }
    end
  end

end

