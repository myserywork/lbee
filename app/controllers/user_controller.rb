class UserController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:edit, :auth_callback, :signup, :signin, :forget, :forgetpass]

  def index
    @user = User.find_by(:nick_name => params[:user_nick].downcase)

    return redirect_to "/" if @user.nil?

    if cookies[:lbee_userHasAcess]
      @currentUserA = User.find_by(:app_access_token => cookies[:lbee_userToken])
      if @user.id == @currentUserA.id
        @itsMe = true
      else

      end
    else
      @itsMe = false
    end

    @friends = Friend.where("friend_id = ? or user_id = ?",@user.id,@user.id)
    @messages = Message.where("friend_id = ? and read = ?",@user.id,false)
    @teams = User.find_by(:nick_name => params[:user_nick].downcase)
    #Pusher['test_channel'].trigger('my_event', {
        #message: 'hello world oi'
    #})
  end

  def signup

    if params[:create] == "true"

      @currentUser = User.new()
      @currentUser.name = params[:name]
      @currentUser.last_name = params[:lastname]
      @currentUser.email = params[:email]
      @currentUser.password = params[:password]
      @currentUser.birthdate = params[:birthdate]
      @currentUser.country = params[:country]
      @currentUser.primary_game = params[:primary_game]
      @currentUser.nick_name = params[:nick_name].downcase
      @currentUser.img_avatar = params[:imgurl]
      @currentUser.my_resume = params[:my_resume]
      @currentUser.token_confirmation = Digest::SHA2.hexdigest([Time.now, rand].join)
      @currentUser.active = FALSE

      @problems = "Problemas ao cadastrar usuario" unless @currentUser.save

      return unless @currentUser.save

      UserMailer.welcome_email(@currentUser).deliver

      return redirect_to "/?user_created=true"

    end

  end

  def signin

    @currentUser = User.find_by(:nick_name =>params[:nick_name].downcase)

    return redirect_to "/?user_login_error=true" if @currentUser.nil?

    return redirect_to "/?user_login_error=true" unless @currentUser.has_password?(params[:password])

    return redirect_to "/?user_login_inativo=true" unless @currentUser.active?

    cookies.permanent[:lbee_userHasAcess] = TRUE
    cookies.permanent[:lbee_userToken] = [@currentUser.app_access_token]

    return redirect_to "/?user_login=true"

  end

  def confirmation
    @currentUser = User.find_by(:token_confirmation => params[:token])

    return redirect_to "/?confirmation_invalid=true" if @currentUser.nil?

    @currentUser.active = true
    @currentUser.token_confirmation = Digest::SHA2.hexdigest([Time.now, rand].join)
    @currentUser.save!

    return redirect_to "/?confirmation=true"

  end

  def logout

    #@currentUser = User.find_by(:app_access_token => cookies[:lbee_userToken])
    #@currentUser.app_access_token = Digest::SHA2.hexdigest([Time.now, rand].join)
    #@currentUser.save!

    cookies.delete :lbee_userHasAcess
    cookies.delete :lbee_userToken

    return redirect_to "/?user_logout=true"
  end

  def auth_callback
    auth = request.env['omniauth.auth']
    @auth = auth
    #session[:current_user] = { :nickname => auth.info['nickname'],
                               #:image => auth.info['image'],
                               #:uid => auth.uid }
    #redirect_to root_url
  end

  def edit
    @user = User.find_by(:app_access_token => cookies[:lbee_userToken])

    return redirect_to "/" if @user.nil?

    if params[:save] == "true"
        @user.name = params[:name]
        @user.last_name = params[:last_name]
        @user.my_resume = params[:my_resume]
        @user.acc_fb = params[:acc_fb]
        @user.acc_twitter = params[:acc_twitter]
        @user.acc_ig = params[:acc_ig]
        @user.acc_tube = params[:acc_tube]
        @user.acc_twitch = params[:acc_twitch]
        @user.acc_steam = params[:acc_steam]
        @user.save!

        @edit_message = "Dados salvos com sucesso"
    end

    if params[:save_password] == "true"

      if @user.has_password?(params[:old_password])
        @user.password = params[:new_password]
        @user.encrypt_password
        @user.save
        @edit_message = "Sua senha foi alterada com sucesso"
      else
        @edit_message = "Senha atual incorreta"
      end

    end

    @itsMe = true

    @friends = Friend.where("friend_id = ? or user_id = ?",@user.id,@user.id)
    @messages = Message.where("friend_id = ? and read = ?",@user.id,false)
    @teams = User.find_by(:nick_name => @user.nick_name.downcase)

  end

  def messages

  end

  def forget

    if params[:create] == "true"
      @currentUser = User.find_by(:email => params[:email])

      return redirect_to "/?remember_invalid=true" if @currentUser.nil?

      @currentUser.token_reset_confirmation = Digest::SHA2.hexdigest([Time.now, rand].join)
      @currentUser.save!

      UserMailer.forget_email(@currentUser).deliver

      return redirect_to "/?remember=true"
    end

  end

  def forgetpass

    @currentUser = User.find_by(:token_reset_confirmation => params[:token])

    return redirect_to "/?remember_invalid=true" if @currentUser.nil?

    if params[:create] == "true"

      @currentUser.password = params[:password]
      @currentUser.token_reset_confirmation = Digest::SHA2.hexdigest([Time.now, rand].join)
      @currentUser.encrypt_password
      @currentUser.save

      return redirect_to "/?reset=true"

    end

  end

end
