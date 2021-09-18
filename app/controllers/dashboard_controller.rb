
class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @ready_to_ship = @merchant.items
                              .select(:name, 'invoice_items.invoice_id', 'invoice_items.created_at AS invoice_created')
                              .joins(:invoice_items)
                              .where.not('invoice_items.status = ?', 2)
                              .order("invoice_created")
  end
end
