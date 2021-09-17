class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items
    pry
  end

  def show
    @item = Item.find(params[:id])
  end
end
