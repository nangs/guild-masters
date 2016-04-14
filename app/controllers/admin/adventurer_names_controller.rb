class Admin::AdventurerNamesController < AdminController
  before_action :set_adventurer_name, only: [:show, :edit, :update, :destroy]
  before_action :authorized_admin

  def index
    @grid = AdventurerNamesGrid.new(params[:adventurer_names_grid]) do |scope|
      scope.page(params[:page])
    end
  end

  def show
  end

  def new
    @adventurer_name = AdventurerName.new
  end

  def edit
  end

  def create
    @adventurer_name = AdventurerName.new(adventurer_name_params)

    respond_to do |format|
      if @adventurer_name.save
        format.html { redirect_to [:admin, @adventurer_name], notice: 'Adventurer name was successfully created.' }
        format.json { render :show, status: :created, location: @adventurer_name }
      else
        format.html { render :new }
        format.json { render json: @adventurer_name.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @adventurer_name.update(adventurer_name_params)
        format.html { redirect_to [:admin, @adventurer_name], notice: 'Adventurer name was successfully updated.' }
        format.json { render :show, status: :ok, location: @adventurer_name }
      else
        format.html { render :edit }
        format.json { render json: @adventurer_name.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @adventurer_name.destroy
    respond_to do |format|
      format.html { redirect_to admin_adventurer_names_path, notice: 'Adventurer name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_adventurer_name
    @adventurer_name = AdventurerName.find(params[:id])
  end

  def adventurer_name_params
    params.require(:adventurer_name).permit(:name)
  end
end
