class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.all_enabled
    @disabled_merchants = Merchant.all_disabled
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:merchant][:status]
      merchant.update(merchant_params)
      redirect_back fallback_location: admin_merchant_path
    end

    if params[:merchant][:name]
      merchant.update(merchant_params)
      redirect_to admin_merchant_path(merchant)
      flash[:success] = "Merchant has been successfully updated"
    end
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end
