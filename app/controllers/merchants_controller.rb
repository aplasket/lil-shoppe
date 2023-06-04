class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @customers = Customer.top_5_by_transaction
  end
end
