class UserMailer < ActionMailer::Base
  default from: "lbee@lucasluz.com"

  def contact_user(user)
    @user = user
    mail(to: @user.email, subject: 'Contato LBEE')
  end

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to LBEE')
  end

  def forget_email(user)
    @user = user
    mail(to: @user.email, subject: 'Pedido de alteração de senha LBEE')
  end


  def welcome_team(team,user)
    @team = team
    @user = user
    mail(to: @user.email, subject: 'Confirmação de cadastro de time LBEE')
  end

  def invite_email(from,to,invite)
    @user_from = from
    @user_to = to
    @invite = invite
    mail(to: @user_to.email, subject: 'Convite de amizade LBEE')
  end

  def invite_team_email(from,to,invite)
    @user_from = from
    @user_to = to
    @invite = invite
    mail(to: @user_to.email, subject: 'Convite de amizade LBEE')
  end

end
