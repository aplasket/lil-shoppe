class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
    item.update(item_params)
    redirect_to "/merchants/#{merchant_1.id}/items/#{item_1.id}
    end
  end

private

  def merchant_items_params
    params.require(:item).permit(:id, :name, :description, :unit_price, :merchant_id)
  end
end