json.extract! invoice, :id, :invoice_number, :invoice_date, :invoice_from, :invoice_to, :total_amount_due, :emails, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
json.pdf_url invoice_url(invoice, format: :pdf)
