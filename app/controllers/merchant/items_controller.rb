class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    if merchant.items.find(params[:item_id]).update(item_params)
      redirect_to merchant_item_path(merchant, merchant.items.find(params[:item_id]))
      flash[:success] = "** Item information has been successfully updated **"
    end
  end

  private

  def item_params
    params.require(:item).permit(:id, :name, :description, :unit_price, :merchant_id)
  end
end