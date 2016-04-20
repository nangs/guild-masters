class Admin::QuestDescriptionsController < AdminController
  before_action :set_quest_description, only: [:show, :edit, :update, :destroy]
  before_action :authorized_admin

  def index
    @grid = QuestDescriptionsGrid.new(params[:quest_descriptions_grid]) do |scope|
      scope.page(params[:page])
    end
  end

  def show
  end

  def new
    @quest_description = QuestDescription.new
  end

  def create
    @quest_description = QuestDescription.new(quest_description_params)

    respond_to do |format|
      if @quest_description.save
        format.html { redirect_to [:admin, @quest_description], notice: 'Quest description was successfully created.' }
        format.json { render :show, status: :created, location: @quest_description }
      else
        format.html { render :new }
        format.json { render json: @quest_description.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @quest_description.update(quest_description_params)
        format.html { redirect_to [:admin, @quest_description], notice: 'Quest description was successfully updated.' }
        format.json { render :show, status: :ok, location: @quest_description }
      else
        format.html { render :edit }
        format.json { render json: @quest_description.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @quest_description.destroy
    respond_to do |format|
      format.html { redirect_to admin_quest_descriptions_path, notice: 'Quest description was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_quest_description
    @quest_description = QuestDescription.find(params[:id])
  end

  def quest_description_params
    params.require(:quest_description).permit(:description)
  end
end
