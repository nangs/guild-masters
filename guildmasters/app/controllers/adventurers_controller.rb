class AdventurersController < ApplicationController

  def index
    @adventurers = Adventurer.all
  end

  def show
    @adventurer = Adventurer.find(params[:state])
  end

  def new
    @adventurer = Adventurer.new
  end

  def create
    @adventurer = Adventurer.new(adventurer_params)
    if @adventurer.save
      redirect_to adventurer_path, :notice => "Adventurer was created"
    else
      render "new"
    end
  end

  def update
  end

  def destroy
  end

  def adventurer_params
    allow = [:state, :hp, :attack, :defense]
    params.require(:adventurer).permit(allow)
  end

end