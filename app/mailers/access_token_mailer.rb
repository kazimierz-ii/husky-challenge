class AccessTokenMailer < ApplicationMailer
  def created
    @user = params[:user]
    @access_token = params[:access_token]

    mail(to: @user.email, subject: "New Access Token")
  end

  def activated
    @user = params[:user]
    @access_token = params[:access_token]

    mail(to: @user.email, subject: "Access Token activated")
  end
end
