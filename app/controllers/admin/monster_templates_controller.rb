class Admin::MonsterTemplatesController < AdminController
  before_action :set_monster_template, only: [:show, :edit, :update, :destroy]
  before_action :authorized_admin

  def index
    @grid = MonsterTemplatesGrid.new(params[:monster_templates_grid]) do |scope|
      scope.page(params[:page])
    end
  end

  def show
  end

  def new
    @monster_template = MonsterTemplate.new
  end

  def create
    @monster_template = MonsterTemplate.new(monster_template_params)

    respond_to do |format|
      if @monster_template.save
        format.html { redirect_to [:admin, @monster_template], notice: 'Monster template was successfully created.' }
        format.json { render :show, status: :created, location: @monster_template }
      else
        format.html { render :new }
        format.json { render json: @monster_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @monster_template.update(monster_template_params)
        format.html { redirect_to [:admin, @monster_template], notice: 'Monster template was successfully updated.' }
        format.json { render :show, status: :ok, location: @monster_template }
      else
        format.html { render :edit }
        format.json { render json: @monster_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @monster_template.destroy
    respond_to do |format|
      format.html { redirect_to admin_monster_templates_path, notice: 'Monster template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_monster_template
    @monster_template = MonsterTemplate.find(params[:id])
  end

  def monster_template_params
    params.require(:monster_template).permit(:name, :max_hp, :max_energy, :attack, :defense, :invisibility)
  end
end
