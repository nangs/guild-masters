class Admin::MonsterTemplatesController < AdminController
  before_action :set_adventurer_name, only: [:show, :edit, :update, :destroy]

  def index
    @grid = MonsterTemplatesGrid.new(params[:monster_templates_grid]) do |scope|
      scope.page(params[:page])
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
    def set_adventurer_name
      @monster_template = MonsterTemplate.find(params[:id])
    end

end

