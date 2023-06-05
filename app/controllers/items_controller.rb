class Merchant::ItemsController < ApplicationController
  before_action :set_merchant
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @item_statuses = {}

    @items.each do |item|
      @item_statuses[item.id] = item.enabled? ? "Enabled" : "Disabled"
    end
  end

  def update
    if params[:disable].present?
      @item.update(status: "Disabled")
      redirect_to merchant_items_path(@merchant)
    elsif params[:enable].present?
      @item.update(status: "Enabled")
      redirect_to merchant_items_path(@merchant)
    else
      if @item.update(item_params)
        redirect_to merchant_items_path(@merchant), notice: "Item information has been successfully updated."
      else
        render :edit
      end
    end
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def set_item
    @item = @merchant.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :price)
  end
end