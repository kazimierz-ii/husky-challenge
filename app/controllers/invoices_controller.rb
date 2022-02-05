class InvoicesController < ApplicationController
  before_action do
    redirect_to(root_path, notice: 'Unauthorized access!') if request.format.html? && !current_user
  end

  before_action :set_invoice, only: %i[ show edit update ]

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
