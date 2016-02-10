class AdventurersController < ApplicationController
  skip_before_action :verify_authenticity_token

# GET /adventurers.json
  def index
    @adventurers = Adventurer.view_all
    respond_to do |format|
      format.json { render json: @adventurers }
    end
  end

  # POST /adventurers.json
  def create
    @adventurer = Adventurer.generate
    respond_to do |format|
      format.json { render json: @adventurer }
    end
  end
end
