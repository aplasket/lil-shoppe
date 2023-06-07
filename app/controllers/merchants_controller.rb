class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @customers = Customer.top_5_by_transaction
    @merchant_image = RandomSearch.new.new_random_image
  end
end
