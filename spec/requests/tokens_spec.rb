require 'rails_helper'

RSpec.describe "/tokens", type: :request do
  let(:user) { User.create(email: 'user@example.com') }
  let(:access_token) { AccessToken.create(user: user) }
  let(:valid_attributes) { { token: access_token.token } }
  let(:invalid_attributes) { { token: 'token-not-valid' } }

  describe "GET /activate" do
    context "with valid parameters" do
      it "activate token" do
        get activate_token_url(valid_attributes[:token])
        expect(response).to redirect_to(invoices_path)
      end
    end

    context "with invalid parameters" do
      it "try do activate invalid token" do
        get activate_token_url(invalid_attributes[:token])
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "access with token" do
        access_token.approve! # Aprova o token antes de fazer o request
        post tokens_url, params: valid_attributes
        expect(response).to redirect_to(invoices_path)
      end
    end

    context "with invalid parameters" do
      it "access with invalid token" do
        post tokens_url, params: invalid_attributes
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
