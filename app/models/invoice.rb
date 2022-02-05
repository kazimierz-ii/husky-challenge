class Invoice < ApplicationRecord
  belongs_to :user

  after_save do
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
