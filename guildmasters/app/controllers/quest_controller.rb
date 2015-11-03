class QuestController < ApplicationController
# GET /adventurers
# GET /adventurers.json
  def viewall
    @quest = Quest.viewall
    respond_to do |format|
      #format.html # index.html.erb
      format.json { render json: @quest }
    end
  end

  def generate
    @quest = Quest.generate
    respond_to do |format|
      #format.html # index.html.erb
      format.json { render json: @quest }
    end
  end
#
# # GET /adventurers/1.json
#   def show
#     @quest = Quest.find(params[:id])
#
#     respond_to do |format|
#       format.json { render json: @adventurer }
#     end
#   end
#
# # POST /adventurers.json
#   def create
#     @adventurer = Adventurer.new(params[:id])
#
#     respond_to do |format|
#       if @adventurer.save
#         format.json { render json: @adventurer, status: :created, location: @adventurer }
#       else
#         format.json { render json: @adventurer.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
# # PUT /adventurers/1.json
#   def update
#     @adventurer = Adventurer.find(params[:id])
#
#     respond_to do |format|
#       if @adventurer.update_attributes(params[:adventurer])
#         format.json { render json: nil, status: :ok }
#       else
#         format.json { render json: @adventurer.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
# # DELETE /adventurers/1.json
#   def destroy
#     @adventurer = Adventurer.find(params[:id])
#     @adventurer.destroy
#
#     respond_to do |format|
#       format.json { render json: nil, status: :ok }
#     end
#   end
end




# def index
#   @adventurers = Adventurer.all
# end
#
# def show
#   @adventurer = Adventurer.find(params[:hp])
# end
#
# def new
#   @adventurer = Adventurer.new
# end
#
# def create
#   @adventurer = Adventurer.new(adventurer_params)
#   if @adventurer.save
#     redirect_to adventurer_path, :notice => "Adventurer was created"
#   else
#     render "new"
#   end
# end
#
# def update
# end
#
# def destroy
# end
#
# def adventurer_params
#   allow = [:state, :hp, :attack, :defense]
#   params.require(:adventurer).permit(allow)
# end