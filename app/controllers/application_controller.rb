class ApplicationController < ActionController::Base

  protect_from_forgery unless: -> { request.format.json? }

  helper_method :current_user

  def current_user
    return if session[:current_user_id].nil? && params[:token].nil?

    @user ||= User.find(session[:current_user_id]) if session[:current_user_id]
    @user ||= AccessToken.approved.find_by_token(params[:token]).user if params[:token]
    @user
  end

end
