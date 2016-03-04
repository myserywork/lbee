class RankingController < ApplicationController
  def index
    @active = "ranking"
    @games = Game.all
    if params[:game] == "todos"
      @teams = Team.all
    else
      @g = Game.find_by(:name => params[:game])
      @teams = Team.where(game_id: @g.id)
    end

  end
end
