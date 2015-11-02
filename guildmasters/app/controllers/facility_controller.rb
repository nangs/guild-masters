class FacilityController < ApplicationController
  def index
    @facilities = Facility.all
  end

  def show
    @facility = Facility.find(params[:id])
  end

  def new
    @facility = Facility.new
  end

  def create
    @facility = Facility.new(params[:facility])
    if @facility.save
      #redirect_to adventurer_path, :notice => "Facility was created"
    else
      #render "new"
    end
  end

  def update
  end

  def destroy
  end
end