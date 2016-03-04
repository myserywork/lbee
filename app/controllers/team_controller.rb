class TeamController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:signup, :edit, :conf]

  def index

    @team = Team.find_by(:name => params[:team_name])

    return redirect_to "/?team_invalid=true" if @team.nil?

    return redirect_to "/?team_inactive=true" if @team.active == false

    if cookies[:lbee_userHasAcess]
      @currentUserA = User.find_by(:app_access_token => cookies[:lbee_userToken])

      if @currentUserA.team_members.find_by(:team_id => @team.id).nil?
        @imMember = false
      else
        @imMember = true
      end

      if @currentUserA.team_members.find_by(:team_id => @team.id, :permission_id => 1).nil?
        @imAdmin = false
      else
        @imAdmin = true
      end

    else
      @imAdmin = false
      @imMember = false
    end

    @members = TeamMember.where(:team_id => @team.id)

  end

  def signup

    if params[:create] == "true"

      @team = Team.new()
      @team.name = params[:name]
      @team.website = params[:website]
      @team.password = params[:password]
      @team.about = params[:about]
      @team.game_id = params[:game]
      @team.img_logo = params[:imgurl]
      @team.token_confirmation = Digest::SHA2.hexdigest([Time.now, rand].join)
      @team.active = FALSE

      @problems = @team.errors.as_json unless @team.save

      return unless @team.save

      @currentUser = User.find_by(:app_access_token => cookies[:lbee_userToken])

      @user = TeamMember.new()
      @user.team_id = @team.id
      @user.user_id = @currentUser.id
      @user.permission_id = 1

      @user.save

      UserMailer.welcome_team(@team,@currentUser).deliver

      return redirect_to "/team/"+@team.name

    end

  end

  def confirmation
    @team = Team.find_by(:token_confirmation => params[:token])

    return redirect_to "/?confirmationteam_invalid=true" if @team.nil?

    @team.active = true
    @team.token_confirmation = Digest::SHA2.hexdigest([Time.now, rand].join)
    @team.save!

    return redirect_to "/team/"+@team.name

  end

  def invite

    @current_from = User.find_by(:app_access_token => cookies[:lbee_userToken])

    #regra para so pessoas membras do time darem invite...
    return redirect_to "/?action_failA=true" if @current_from.team_members.find_by(:team_id => params[:team_id]).nil?

    @current_to = User.find_by(:nick_name => params[:to].downcase)

    @pre_invite = TeamMember.where("user_id = ? and team_id = ?",@current_to.id,params[:team_id])
    @pre_invite1 = TeamInvite.where("user_id = ? and team_id = ?",@current_to.id,params[:team_id])

    if @pre_invite.count > 0 || @pre_invite1.count > 0
      return redirect_to "/?action_fail=true"
    end

    @invite = TeamInvite.new()
    @invite.user_id = @current_to.id
    @invite.team_id = params[:team_id]
    @invite.invite_token = Digest::SHA2.hexdigest([Time.now, rand].join)

    return redirect_to "/?action_fail=true" unless @invite.save

    UserMailer.invite_team_email(@current_from,@current_to,@invite).deliver

    return redirect_to "/?invite_team=true"

  end

  def userconfirmation

    @invite = TeamInvite.find_by(:invite_token => params[:token])

    return redirect_to "/?action_fail=true" if @invite.nil?

    @current_to = User.find_by_id(@invite.user_id)

    @member = TeamMember.new()
    @member.team_id = @invite.team_id
    @member.user_id = @current_to.id
    @member.permission_id = 2

    @member.save

    return redirect_to "/?action_fail=true" if @member.nil?

    @invite.destroy

    return redirect_to "/?confirmation=true"

  end

  def user
    @user = User.find_by(:app_access_token => cookies[:lbee_userToken])

    return redirect_to "/" if @user.nil?

    @itsMe = true

    @friends = Friend.where("friend_id = ? or user_id = ?",@user.id,@user.id)
    @messages = Message.where("friend_id = ? and read = ?",@user.id,false)
    @teams = User.find_by(:nick_name => @user.nick_name.downcase)
  end

  def edit

    @team = Team.find_by(:name => params[:team_name])

    return redirect_to "/?team_invalid=true" if @team.nil?

    return redirect_to "/?team_inactive=true" if @team.active == false

    if cookies[:lbee_userHasAcess]
      @currentUserA = User.find_by(:app_access_token => cookies[:lbee_userToken])

      #if @currentUserA.team_members.find_by(:team_id => @team.id).nil?
        #@imMember = false
      #else
        #@imMember = true
      #end

      if @currentUserA.team_members.find_by(:team_id => @team.id, :permission_id => 1).nil?
        return redirect_to "/?team_invalid=true"
      else
        @imAdmin = true
      end

    else
      return redirect_to "/?team_invalid=true"
    end

    @members = TeamMember.where(:team_id => @team.id)

    if params[:save] == "true"
      #@team.name = params[:name]
      @team.about = params[:my_resume]
      @team.acc_fb = params[:acc_fb]
      @team.acc_twitter = params[:acc_twitter]
      @team.acc_ig = params[:acc_ig]
      @team.acc_tube = params[:acc_tube]
      @team.acc_twitch = params[:acc_twitch]
      @team.acc_steam = params[:acc_steam]
      @team.save!

      @edit_message = "Dados salvos com sucesso"
    end

    if params[:save_password] == "true"

      if @team.password == params[:old_password]
        @team.password = params[:new_password]
        @team.save
        @edit_message = "Senha foi alterada com sucesso"
      else
        @edit_message = "Senha atual incorreta"
      end

    end

  end

  def conf

    @team = Team.find_by(:name => params[:team_name])

    @team_p = TeamPermission.all

    return redirect_to "/?team_invalid=true" if @team.nil?

    return redirect_to "/?team_inactive=true" if @team.active == false

    if cookies[:lbee_userHasAcess]
      @currentUserA = User.find_by(:app_access_token => cookies[:lbee_userToken])

      #if @currentUserA.team_members.find_by(:team_id => @team.id).nil?
      #@imMember = false
      #else
      #@imMember = true
      #end

      if @currentUserA.team_members.find_by(:team_id => @team.id, :permission_id => 1).nil?
        return redirect_to "/?team_invalid=true"
      else
        @imAdmin = true
      end

    else
      return redirect_to "/?team_invalid=true"
    end

    @members = TeamMember.where(:team_id => @team.id)

    if params[:edit_members] == "true"

      @members.each do |member|

        if params[:"select_#{member.user.id}"] == "del"
          TeamMember.where(:user_id => member.user.id, :team_id => @team.id).destroy_all

        else

        end

        @edit_message = "Edita com sucesso"

      end



    end

    if params[:delete] == "true"
      if @imAdmin
        TeamMember.where(:team_id => @team.id).destroy_all
        TeamInvite.where(:team_id => @team.id).destroy_all
        @team.destroy!
        return redirect_to "/?team_deleted=true"
      end
    end

  end

end
