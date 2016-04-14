class Admin::AdventurerTemplatesController < AdminController
  before_action :set_adventurer_template, only: [:show, :edit, :update, :destroy]
  before_action :authorized_admin

  def index
    @grid = AdventurerTemplatesGrid.new(params[:adventurer_templates_grid]) do |scope|
      scope.page(params[:page])
    end
  end

  def show
  end

  def new
    @adventurer_template = AdventurerTemplate.new
  end

  def create
    @adventurer_template = AdventurerTemplate.new(adventurer_template_params)

    respond_to do |format|
      if @adventurer_template.save
        format.html { redirect_to [:admin, @adventurer_template], notice: 'Adventurer template was successfully created.' }
        format.json { render :show, status: :created, location: @adventurer_template }
      else
        format.html { render :new }
        format.json { render json: @adventurer_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @adventurer_template.update(adventurer_template_params)
        format.html { redirect_to [:admin, @adventurer_template], notice: 'Adventurer template was successfully updated.' }
        format.json { render :show, status: :ok, location: @adventurer_template }
      else
        format.html { render :edit }
        format.json { render json: @adventurer_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @adventurer_template.destroy
    respond_to do |format|
      format.html { redirect_to admin_adventurer_templates_path, notice: 'Adventurer template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_adventurer_template
    @adventurer_template = AdventurerTemplate.find(params[:id])
  end

  def adventurer_template_params
    params.require(:adventurer_template).permit(:max_hp, :max_energy, :attack, :defense, :vision)
  end
end
