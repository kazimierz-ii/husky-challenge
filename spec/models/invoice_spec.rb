require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let(:user) {
    User.create(email: 'user@example.com')
  }
  subject {
    described_class.new(
      user_id: user.id,
      invoice_number: '20220206-000001',
      invoice_date: 7.days.from_now.to_date,
      invoice_from: 'Company X',
      invoice_to: 'Company Y',
      total_amount_due: '$ 499',
      emails: 'user@example.com, example@user.com'
    )
  }

  describe "Associations" do
    it { should belong_to(:user) }
  end

  describe "Validations" do
    it { should be_valid }
  end

  describe "Mailers" do
    it 'sends an email' do
      expect { subject.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
