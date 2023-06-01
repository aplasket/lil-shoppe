require "csv"

namespace :csv_load do
  desc "Import all CSV data"
  task all: [:customers, :merchants, :invoices, :transactions, :items, :invoice_items]

  desc "imports customer data from CSV and creates Customer objects"
  task customers: :environment do
    Customer.destroy_all
    file = "db/data/customers.csv"
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      details = row.to_hash
      Customer.create!(details)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:customers)
  end

  desc "imports merchant data from CSV and creates Merchant objects"
  task merchants: :environment do
    Merchant.destroy_all
    file = "db/data/merchants.csv"
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      details = row.to_hash
      Merchant.create!(details)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:merchants)
  end

  desc "imports invoice data from CSV and creates Invoice objects"
  task invoices: :environment do
    Invoice.destroy_all
    file = "db/data/invoices.csv"
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      details = row.to_hash
      Invoice.create!(details)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:invoices)
  end

  desc "imports item data from CSV and creates Item objects"
  task items: :environment do
    Item.destroy_all
    file = "db/data/items.csv"
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      details = row.to_hash
      Item.create!(details)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:items)
  end

  desc "imports transaction data from CSV and creates Transaction objects"
  task transactions: :environment do
    Transaction.destroy_all
    file = "db/data/transactions.csv"
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      details = row.to_hash
      Transaction.create!(details)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:transactions)
  end

  desc "imports invoice_items data from CSV and creates InvoiceItem objects"
  task invoice_items: :environment do
    InvoiceItem.destroy_all
    file = "db/data/invoice_items.csv"
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      details = row.to_hash
      InvoiceItem.create!(details)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:invoice_items)
  end
end
