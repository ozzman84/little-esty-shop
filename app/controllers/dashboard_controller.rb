
class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @ready_to_ship = @merchant.items
                              .select(:name, 'invoice_items.invoice_id')
                              .joins(:invoice_items)
                              .where.not('invoice_items.status = ?', 2)
                              .order(:id, :invoice_id)
  end
end
