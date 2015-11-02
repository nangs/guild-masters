class GuildController < ApplicationController
  def index
    @guilds = Guild.all
  end

  def show
    @guild = Guild.find(params[:id])
  end

  def new
    @guild = Guild.new
  end

  def create
    @guild = Guild.new(params[:guild])
    if @guild.save
      #redirect_to adventurer_path, :notice => "Guild was created"
    else
      #render "new"
    end
  end
end

