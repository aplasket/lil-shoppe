class UpdateTransactions < ActiveRecord::Migration[7.0]
  def change
      change_table :transactions do |t|
        t.rename :credit_card_expiration, :credit_card_expiration_date
      end
  end
end
