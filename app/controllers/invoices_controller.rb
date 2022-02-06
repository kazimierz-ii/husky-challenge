class InvoicesController < ApplicationController
  before_action do
    if request.format.html?
      if action_name != 'api_doc' && !current_user
        redirect_to(root_path, notice: 'Unauthorized access!')
      end
    elsif request.format.json?
      access_token = AccessToken.approved.find_by_token(params[:token])
      if access_token
        access_token.touch_last_access_at!
      else
        render json: { message: 'You need a valid token to use the API.' }, status: :unauthorized
      end
    end
  end

  before_action :set_invoice, only: %i[ show edit update ]

  def api_doc
    @sample_invoice = {
      id: 789456,
      invoice_number: '789456123',
      invoice_date: Date.today,
      invoice_from: 'Sample invoice from',
      invoice_to: 'Sample invoice to',
      total_amount_due: '$ 199',
      emails: 'sample@email.com,email@sample.com',
      url: invoice_url(789456, format: :json),
      pdf_url: invoice_url(789456, format: :pdf)
    }
    respond_to do |format|
      format.html
    end
  end

  def index
    @invoices = Invoice.all
    if params[:invoice_number]
      @invoices = @invoices.where('invoice_number LIKE ?', "%#{params[:invoice_number]}%")
    end
    if params[:invoice_date_from]
      @invoices = @invoices.where('invoice_date >= ?', params[:invoice_date_from])
    end
    if params[:invoice_date_to]
      @invoices = @invoices.where('invoice_date <= ?', params[:invoice_date_to])
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json
      format.pdf do
        send_data(@invoice.pdf, filename: "invoice_#{@invoice.id}.pdf", type: 'application/pdf')
      end
    end
  end

  def new
    @invoice = Invoice.new
  end

  def edit
    @new_invoice = @invoice.dup
  end

  def create
    @invoice = current_user.invoices.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully created and sent to the emails." }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @new_invoice = @invoice.dup
    @new_invoice.user_id = current_user.id
    @new_invoice.emails = invoice_params[:emails]

    respond_to do |format|
      if @new_invoice.save
        format.html { redirect_to invoice_url(@new_invoice), notice: "Invoice was successfully created and sent to the emails." }
        format.json { render :show, status: :ok, location: @new_invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @new_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:invoice_number, :invoice_date, :invoice_from, :invoice_to, :total_amount_due, :emails)
    end
end
