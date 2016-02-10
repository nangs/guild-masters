class GuildmasterController < ApplicationController
  # GET /guildmaster.json
  def index
  end

  def create
    if !params[:id].nil?
      gmId = params[:id]
      @guildmaster = Account.find_by(gmId).guildmaster
      respond_to do |format|
        format.json { render json: @guildmaster }
      end
    else
    end
  end

  def show
    if !params[:id].nil?
      acc = Account.find(params[:id])
      gm = acc.guildmaster
      respond_to do |format|
        format.json { render json: gm }
      end
    else
    end
  end
end

