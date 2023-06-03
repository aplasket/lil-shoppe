class AdminController < ApplicationController
  def index
    @customers = Customer.top_5_by_transaction
    @invoices = Invoice.find_and_sort_incomplete_invoices
  end
end
