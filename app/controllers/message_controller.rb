class MessageController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:show]

  def index

    if cookies[:lbee_userHasAcess]
      @user = User.find_by(:app_access_token => cookies[:lbee_userToken])
    end
    return redirect_to "/" if @user.nil?

    #@user_to = User.find_by(:nick_name => params[:to].downcase)

    @itsMe = true

    @friends = Friend.where("friend_id = ? or user_id = ?",@user.id,@user.id)
    @messages = Message.where("friend_id = ? and read = ?",@user.id,false)
    @teams = User.find_by(:nick_name => @user.nick_name.downcase)

    @channel = MessageChannel.where("user_id = ? or friend_id = ?",@user.id,@user.id)

  end

  def show

    if cookies[:lbee_userHasAcess]
      @user = User.find_by(:app_access_token => cookies[:lbee_userToken])
    end
    return redirect_to "/" if @user.nil?

    @user_to = User.find_by(:nick_name => params[:to].downcase)

    @itsMe = true

    @friends = Friend.where("friend_id = ? or user_id = ?",@user.id,@user.id)
    @messages = Message.where("friend_id = ? and read = ?",@user.id,false)
    @teams = User.find_by(:nick_name => @user.nick_name.downcase)

    if (params[:create] == "true")
      @channel = MessageChannel.where("user_id = ? and friend_id = ? or friend_id = ? and user_id = ?",@user.id,@user_to.id,@user.id,@user_to.id)

      if(@channel.count <= 0)
        @channel_ = MessageChannel.new()
        @channel_.user_id = @user.id
        @channel_.friend_id = @user_to.id
        @channel_.save!
      end

      @messages = Message.new()
      @messages.user_id = @user.id
      @messages.friend_id = @user_to.id
      @messages.send_by = @user.id
      if(@channel.count <= 0)
        @messages.message_channel_id = @channel_.id
      else
        @messages.message_channel_id = @channel[0].id
      end
      @messages.read = 0
      @messages.msg = params[:msg]
      @messages.save!

    end

    @my_messages = Message.where("user_id = ? and friend_id = ? or friend_id = ? and user_id = ?",@user.id,@user_to.id,@user.id,@user_to.id)

  end

end
