class InvoiceMailer < ApplicationMailer
  def created
    @invoice = params[:invoice]

    emails = @invoice.emails.split(',')

    attachments["invoice_#{@invoice.id}.pdf"] = {
      :mime_type => 'application/pdf',
      :content => @invoice.pdf
    }
    mail(to: emails, subject: "Invoice #{@invoice.id}")
  end
end
