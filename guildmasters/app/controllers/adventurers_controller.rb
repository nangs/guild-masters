class AdventurersController < ApplicationController

  def index
    @adventurers = Adventurer.all
  end

  def show
    @adventurer = Adventurer.find(params[:id])
  end

  def new
    @adventurer = Adventurer.new
  end

  def create
    @adventurer = Adventurer.new(params[:adventurer])
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

end