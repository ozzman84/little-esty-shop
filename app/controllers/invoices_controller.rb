class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.all_invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end
