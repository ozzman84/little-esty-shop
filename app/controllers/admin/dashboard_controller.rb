class Admin::DashboardController < ApplicationController
  def index
    @top_five = Customer.top_five_customers
    @incomplete = InvoiceItem.incomplete_invoices
  end
end
