require 'rails_helper'

RSpec.describe "/invoices", type: :request do
  let(:user) { User.create(email: 'user@example.com') }
  let(:access_token) { AccessToken.create(user: user).approve! }
  let(:valid_attributes) {
    {
      user_id: user.id,
      invoice_number: '20220206-000001',
      invoice_date: 7.days.from_now.to_date,
      invoice_from: 'Company X',
      invoice_to: 'Company Y',
      total_amount_due: '$ 499',
      emails: 'user@example.com, example@user.com'
    }
  }
  let(:invalid_attributes) {
    {
      user_id: nil,
      invoice_number: '20220206-000001',
      invoice_date: 7.days.from_now.to_date,
      invoice_from: 'Company X',
      invoice_to: 'Company Y',
      total_amount_due: '$ 499',
      emails: 'user_at_example.com, example_at_user.com'
    }
  }

  before { post tokens_url, params: { token: access_token.token } }

  describe "GET /index" do
    it "renders a successful response" do
      invoice = Invoice.create! valid_attributes
      get invoices_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      invoice = Invoice.create! valid_attributes
      get invoice_url(invoice)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_invoice_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Invoice" do
        expect {
          post invoices_url, params: { invoice: valid_attributes }
        }.to change(Invoice, :count).by(1)
      end

      it "redirects to the created invoice" do
        post invoices_url, params: { invoice: valid_attributes }
        expect(response).to redirect_to(invoice_url(Invoice.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Invoice" do
        expect {
          post invoices_url, params: { invoice: invalid_attributes }
        }.to change(Invoice, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post invoices_url, params: { invoice: invalid_attributes }
        expect(response).to_not be_successful
      end
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      invoice = Invoice.create! valid_attributes
      get edit_invoice_url(invoice)
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { emails: 'user2@example.com, example2@user.com' } }

      it "updates the requested invoice" do
        invoice = Invoice.create! valid_attributes
        expect {
          patch invoice_url(invoice), params: { invoice: new_attributes }
        }.to change(Invoice, :count).by(1)
      end

      it "redirects to the invoice" do
        invoice = Invoice.create! valid_attributes
        patch invoice_url(invoice), params: { invoice: new_attributes }
        expect(response).to redirect_to(invoice_url(Invoice.last))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        invoice = Invoice.create! valid_attributes
        patch invoice_url(invoice), params: { invoice: invalid_attributes }
        expect(response).to_not be_successful
      end
    end
  end
end
