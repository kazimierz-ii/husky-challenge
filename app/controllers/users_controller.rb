class UsersController < ApplicationController

  def create
    user = User.find_by_email(params[:email])

    unless user
      user = User.new(email: params[:email])
      unless user.save
        redirect_to(root_path, alert: user.errors.full_messages.join("<br/>".html_safe))
        return
      end
    end

    user.access_tokens.create

    redirect_to(root_path, notice: 'Access Token created, check your email to activate it.')
  end

  def logout
    session.delete(:current_user_id)

    redirect_to(root_path)
  end
end
