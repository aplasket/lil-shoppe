class Merchant::ItemsController < ApplicationController
  # before_action :set_merchant

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @enabled_items = @items.enabled
    @disabled_items = @items.disabled
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
    if @item.update(item_params)
      redirect_to merchant_item_path(@merchant, @item)
      flash[:notice] = "Item Successfully Updated"
    else
      redirect_to edit_merchant_item_path(@merchant, @item)
      flash[:alert] = "Error: Valid data must be entered"
    end
  end

  def update_status
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
    require 'pry'; binding.pry
    if params[:commit] == "Disable Item"
      @item.update(status: :disabled)
    elsif params[:commit] == "Enable Item"
      @item.update(status: :enabled)
    end
    redirect_to "/merchants/#{@merchant.id}/items"
  end

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end