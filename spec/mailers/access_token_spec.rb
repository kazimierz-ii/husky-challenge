require "rails_helper"

RSpec.describe AccessTokenMailer, type: :mailer do
  describe 'created' do
    let(:user) { User.create(email: 'user@example.com') }
    let(:access_token) { AccessToken.create(user: user) }
    let(:mail) { described_class.with(user: user, access_token: access_token).created.deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq("New Access Token")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the activate_token_url' do
      expect(mail.body.encoded).to match(activate_token_url(access_token.token))
    end
  end

  describe 'activated' do
    let(:user) { User.create(email: 'user@example.com') }
    let(:access_token) { AccessToken.create(user: user) }
    let(:mail) { described_class.with(user: user, access_token: access_token).activated.deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq("Access Token activated")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the access token' do
      expect(mail.body.encoded).to match(access_token.token)
    end
  end
end
