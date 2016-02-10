class GuildController < ApplicationController
  ########
  ########for testing not for release
  ########
  # GET /guild.json
  def index
    @guild = Guild.all
    respond_to do |format|
      format.json { render json: @guild }
    end
  end
  ########
  ########for testing not for release
  ########

end

