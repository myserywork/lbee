class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def disable_nav
    @disable_nav = true
  end

  def restrict_web_access
    return redirect_to "/" unless cookies[:lbee_userHasAcess]

    @currentUserW = Users.find_by(:app_access_token => cookies[:lbee_userToken])

    if @currentUserW.nil?
      cookies.delete :lbee_userHasAcess
      cookies.delete :lbee_clientWeb
      cookies.delete :lbee_userToken
      cookies.delete :lbee_userName
      cookies.delete :lbee_userImage

      return redirect_to "/"
    end

  end

end
