class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(@item.merchant_id)
  end

  def edit
    @item = Item.find(params[:id])
    @merchant = Merchant.find(@item.merchant_id)
  end

  def update
    item = Item.find(params[:id])
    if params[:status] == "0"
      item.update(status: 0)
      redirect_to merchant_items_path(merchant_id: item.merchant_id)
    elsif params[:status] == "1"
      item.update(status: 1)
      redirect_to merchant_items_path(merchant_id: item.merchant_id)
    else
      item.update(item_params)
      flash[:success] = "Item #{item.name} Successfully Updated!"
      redirect_to merchant_item_path(merchant_id: item.merchant_id, id: item.id)
    end

    def new
      @merchant = Merchant.find(params[:id])
      @item = Item.new
    end

    def create
      @merchant = Merchant.find(params[:id])
      @item = @merchant.items.new(item_params)
      if item.save
        redirect_to merchant_item_path(merchant_id: item.merchant_id, id: item.id)
      else
        redirect_to merchant_item_path(merchant_id: item.merchant_id, "new")
      end
    end




  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end
end