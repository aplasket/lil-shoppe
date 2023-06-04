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
    return unless merchant.items.find(params[:item_id]).update(item_params)

    redirect_to merchant_item_path(merchant, merchant.items.find(params[:item_id]))
    flash[:success] = "** Item information has been successfully updated **"
  end

  def disable
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.find(params[:id])
    item.update(status: :disabled)

    redirect_to merchant_items_path(merchant)
    flash[:success] = "Item has been disabled successfully."
  end

  def enable
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.find(params[:id])
    item.update(status: :enabled)

    redirect_to merchant_items_path(merchant)
    flash[:success] = "Item has been enabled successfully."
  end

  private

  def item_params
    params.require(:item).permit(:id, :name, :description, :unit_price, :merchant_id)
  end
end
