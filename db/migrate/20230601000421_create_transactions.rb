class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :credit_card_number
      t.date :credit_card_expiration
      t.boolean :result
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
