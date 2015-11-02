class EventController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      #redirect_to adventurer_path, :notice => "Event was created"
    else
      #render "new"
    end
  end

  def update
  end

  def destroy
  end

end