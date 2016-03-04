class FriendController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:index]

  def index

    @currentUser = User.find_by(:app_access_token => cookies[:lbee_userToken])

    q = "%#{params[:name]}%"

    #@usersSearch = User.where("name like ? and id != ?",q,@currentUser.id) unless params[:name].nil?
    @usersSearch = User.where("name like ?",q)

  end

  def invite

    @current_from = User.find_by(:app_access_token => cookies[:lbee_userToken])
    @current_to = User.find_by_id(params[:to])

    @pre_invite = FriendInvite.where("user_id = ? and friend_id = ?",@current_from.id,@current_to.id)
    @pre_invite1 = Friend.where("user_id = ? and friend_id = ?",@current_from.id,@current_to.id)
    @pre_invite2 = Friend.where("friend_id = ? and user_id = ?",@current_from.id,@current_to.id)

    if @pre_invite.count > 0 || @pre_invite1.count > 0 || @pre_invite2.count > 0
      return redirect_to "/?invite_friend_invalid=true"
    end

    @invite = FriendInvite.new()
    @invite.user_id = @current_from.id
    @invite.friend_id = params[:to]
    @invite.invite_token = Digest::SHA2.hexdigest([Time.now, rand].join)

    return redirect_to "/?invite_friend_invalid_already=true" unless @invite.save

    UserMailer.invite_email(@current_from,@current_to,@invite).deliver

    return redirect_to "/?invite_friend=true"

  end

  def confirmation

    @invite = FriendInvite.find_by(:invite_token => params[:token])

    return redirect_to "/?invite_friend_invalid=true" if @invite.nil?

    @current_from = User.find_by_id(@invite.user_id)
    @current_to = User.find_by_id(@invite.friend_id)

    @friend = Friend.new()
    @friend.user_id = @current_from.id
    @friend.user_avatar = @current_from.img_avatar
    @friend.friend_avatar = @current_to.img_avatar
    @friend.friend_id = @current_to.id

    @friend.save

    return redirect_to "/?invite_friend_invalid=true" if @friend.nil?

    @invite.destroy

    return redirect_to "/?confirmation=true"

  end

end
