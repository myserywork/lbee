class WelcomeController < ApplicationController
  def index
    if params[:jogo]
      cookies.permanent[:lbee_game] = params[:jogo]
    else
      cookies.permanent[:lbee_game] = "todos"
      return redirect_to "/game/todos"
    end
  end
end
