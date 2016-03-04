class MachineController < ApplicationController
	
  def index
  	@admin_style = true
  end

  def create
    @admin_style = true
  end

  def dashboard
    @admin_style = true
  end

  def news
    @admin_style = true
  end

  def newscreate
    @admin_style = true
  end
  	
 
end
