class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.invoice_items
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update(status: params[:status])

    redirect_to admin_invoice_path(@invoice)

    flash[:notice] = "Invoice status successfully updated"
  end

end
