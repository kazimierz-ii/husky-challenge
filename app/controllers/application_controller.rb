class ApplicationController < ActionController::Base

  helper_method :current_user

  def current_user
    return unless session[:current_user_id]

    @user ||= User.find(session[:current_user_id])
  end

end
