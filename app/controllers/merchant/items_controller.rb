class Merchant::ItemsController < ApplicationController
  # before_action :set_merchant

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def update_status
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:item_id])

    if params[:commit] == "Disable Item"
      @item.update(status: :disabled)
    elsif params[:commit] == "Enable Item"
      @item.update(status: :enabled)
    end

    redirect_to merchant_items_path(@merchant)
  end


  def update_status
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:item_id])

    if params[:commit] == "Disable Item"
      @item.update(status: "disabled")
    elsif params[:commit] == "Enable Item"
      @item.update(status: "enabled")
    end

    redirect_to merchant_items_path(@merchant)
  end


  def item_params
    params.permit(:name, :description, :unit_price)
  end
end