class GuildController < ApplicationController
  # GET /guild.json
  def index
    @guild = Guild.get_info
    respond_to do |format|
      #format.html # index.html.erb
      format.json { render json: @guild }
    end
  end
end

