class QuestsController < ApplicationController
  skip_before_action :verify_authenticity_token
# GET /quests
# GET /quests.json
  def index
    @quests = Quest.view_all
    respond_to do |format|
      format.json { render json: @quests }
    end
  end

# POST /quests.json
  def create
    if params[:cmd] == 'generate'
      @quest = Quest.generate(guild_id)
      respond_to do |format|
        format.json { render json: @quest }
      end

    elsif params[:cmd] == 'assign'
      questId = params[:questId]
      adventurersIds = params[:adventurersIds]
      @quest = Quest.assign(questId,adventurersIds)
      respond_to do |format|
        format.json { render json: @quest.to_json }
      end

    elsif params[:cmd] == 'complete'
      questId = params[:questId]
      @quest = Quest.complete(questId)
      respond_to do |format|
        format.json { render json: @quest }
      end
    end
  end
end
