class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.all_invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
    @items = @invoice.items.where(merchant_id: params[:merchant_id])
  end
end
