class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items
  end

  def new
    @item = Item.new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = 'New item created!'
      redirect_to merchant_items_path
    else
      redirect_to new_merchant_item_path
      flash[:danger] = 'Item not created. Try again.'
    end
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
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

  private

  def item_params
     params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
