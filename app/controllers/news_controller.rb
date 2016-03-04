class NewsController < ApplicationController
  def index
    @news = New.all
    @active = "noticias"
  end

  def show
    @active = "noticias"
  end
end
