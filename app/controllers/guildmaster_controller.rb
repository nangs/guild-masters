class GuildmasterController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json
  before_action :authorize

  # # POST /guildmaster.json
  def create
    acc = Account.find(session[:account_id])
    guildmaster = acc.guildmaster
    result = if params[:cmd] == 'get'
               { msg: 'success', guildmaster: guildmaster }
             elsif params[:cmd].nil?
               { msg: :error, detail: :cmd_nil }
             else
               { msg: :error, detail: :no_such_cmd }
             end
    render json: result.as_json(except: [:created_at, :updated_at])
  end
end
