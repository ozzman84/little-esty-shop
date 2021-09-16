  class Admin::MerchantsController < ApplicationController
    def index
      @merchants = Merchant.all
    end

    def show
      @merchant = Merchant.find(params[:id])
    end

    def edit
      @merchant = Merchant.find(params[:id])
    end

    def update
      @merchant = Merchant.find(params[:id])
      if params[:enable] == 'true'
        @merchant.update(status: params[:status])
        redirect_to "/admin/merchants"
      elsif @merchant.update(merch_params)
        redirect_to "/admin/merchants/#{@merchant.id}"
        flash[:success] = 'Merchant Updated successfully'
      else
        redirect_to "/admin/merchants/#{@merchant.id}/edit"
        flash[:danger] = 'Merchant Not Updated: re-enter information'
      end
    end

    def new
      @merchant = Merchant.new
    end

    def create
    end

    private

    def merch_params
       params.require(:merchant).permit(:name, :status)
    end
  end
