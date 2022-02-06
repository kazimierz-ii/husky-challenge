require "rails_helper"

RSpec.describe InvoiceMailer, type: :mailer do
  describe 'created' do
    let(:user) { User.create(email: 'user@example.com') }
    let(:invoice) {
      Invoice.create(
        user_id: user.id,
        invoice_number: '20220206-000001',
        invoice_date: 7.days.from_now.to_date,
        invoice_from: 'Company X',
        invoice_to: 'Company Y',
        total_amount_due: '$ 499',
        emails: 'user@example.com, example@user.com'
      )
    }
    let(:mail) { described_class.with(invoice: invoice).created.deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq("Invoice #{invoice.id}")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq(invoice.emails.split(', '))
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the invoice_url#show' do
      expect(mail.body.encoded).to match(invoice_url(invoice))
    end

    it 'renders the attachment' do
      expect(mail.attachments.count).to eq(1)
      expect(mail.attachments.first.content_type).to match('application/pdf')
    end
  end
end
