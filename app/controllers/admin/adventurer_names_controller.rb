class Admin::AdventurerNamesController < AdminController
  before_action :set_adventurer_name, only: [:show, :edit, :update, :destroy]
  before_action :authorized_admin


  # GET admin/adventurer_names
  # GET admin/adventurer_names.json
  def index
    @adventurer_names = AdventurerName.all
  end

  # GET admin/adventurer_names/1
  # GET admin/adventurer_names/1.json
  def show
  end

  # GET admin/adventurer_names/new
  def new
    @adventurer_name = AdventurerName.new
  end

  # GET admin/adventurer_names/1/edit
  def edit
  end

  # POST admin/adventurer_names
  # POST admin/adventurer_names.json
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

  # PATCH/PUT admin/adventurer_names/1
  # PATCH/PUT admin/adventurer_names/1.json
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

  # DELETE admin/adventurer_names/1
  # DELETE admin/adventurer_names/1.json
  def destroy
    @adventurer_name.destroy
    respond_to do |format|
      format.html { redirect_to admin_adventurer_names_path, notice: 'Adventurer name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adventurer_name
      @adventurer_name = AdventurerName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adventurer_name_params
      params.require(:adventurer_name).permit(:name)
    end
end
