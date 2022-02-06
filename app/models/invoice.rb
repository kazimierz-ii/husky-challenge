class Invoice < ApplicationRecord
  belongs_to :user

  validates :user, :invoice_number, :invoice_date, :invoice_from, :invoice_to, :total_amount_due, :emails, presence: true
  validate :multiple_emails

  def multiple_emails
    emails.split(/,\s*/).each do |email|
      unless email =~ URI::MailTo::EMAIL_REGEXP
        errors.add(:emails, "are invalid due to #{email}")
      end
    end
  end

  # Achei melhor trocar para after create por causa do fluxo que define quando envia para outros emails
  after_create do
    InvoiceMailer.with(invoice: self).created.deliver_now
  end

  def pdf
    pdf = Prawn::Document.new
    pdf.pad_bottom(20) { pdf.text "Invoice number: #{invoice_number}" }
    pdf.pad_bottom(20) { pdf.text "Invoice date: #{invoice_date}" }
    pdf.pad_bottom(20) { pdf.text "Invoice from: #{invoice_from}" }
    pdf.pad_bottom(20) { pdf.text "Invoice to: #{invoice_to}" }
    pdf.pad_bottom(20) { pdf.text "Total amount due: #{total_amount_due}" }
    pdf.text "Emails: #{emails}"
    pdf.render
  end
end
