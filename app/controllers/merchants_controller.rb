class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @customers = Customer.top_5_by_transaction
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:merchant][:name]
      if merchant.update(merchant_params)
        redirect_to admin_merchant_path(merchant)
        flash[:success] = "Merchant has been successfully updated"
      end
    end
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
