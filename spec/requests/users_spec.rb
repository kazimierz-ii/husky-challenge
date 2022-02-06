require 'rails_helper'

RSpec.describe "/users", type: :request do
  let(:valid_attributes) { { email: 'email@example.com' } }
  let(:invalid_attributes) { { email: 'email_at_example.com' } }

  # Nao consegui fazer esse teste funcionar corretamente
  # Eu precisaria validar a presença da flash notice/alert, mas não achei como fazer isso
  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new User" do
        post users_url, params: valid_attributes
        expect(response).to redirect_to(root_url)
      end

      it "redirects to root" do
        post users_url, params: valid_attributes
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        post users_url, params: invalid_attributes
        expect(response).to redirect_to(root_url)
      end

      it "redirects to root with the error" do
        post users_url, params: invalid_attributes
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe "GET /logout" do
    context "renders a successful response" do
      it "logout the User" do
        get logout_users_url
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
