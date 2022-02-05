class TokensController < ApplicationController
  def index
  end

  def create
    access_token = AccessToken.approved.find_by_token(params[:token])
    if access_token
      access_token.touch_last_access_at!
      session[:current_user_id] = access_token.user_id

      redirect_to(invoices_path, notice: "Valid token, login successful!")
    else
      redirect_to(root_path, alert: "Invalid token!")
    end
  end

  def activate
    access_token = AccessToken.pending_or_approved.find_by_token(params[:id])

    if access_token
      access_token.approve! if access_token.pending?
      access_token.user.access_tokens.pending_or_approved.map { |at| at.revoke! }
      access_token.touch_last_access_at!
      session[:current_user_id] = access_token.user_id

      redirect_to(invoices_path, notice: "Token approved, welcome!")
    else
      redirect_to(root_path, alert: "Invalid token!")
    end
  end
end
