class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @item = Item.find(params[:id])
    if params[:status] == "disabled"
      @item.enabled!
      redirect_to merchant_items_path
    elsif params[:status] == "enabled"
      @item.disabled!
      redirect_to merchant_items_path
    else
      @item.update(item_params)
      redirect_to merchant_item_path
      flash[:success] = "Item updated!"
    end
  end


  def item_params
     params.require(:item).permit(:name, :description, :unit_price)
  end
end
