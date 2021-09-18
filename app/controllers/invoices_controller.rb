class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.all_invoices
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @invoice_items = InvoiceItem.on_merchant_invoice(@invoice.id, params[:merchant_id])
  end
end
