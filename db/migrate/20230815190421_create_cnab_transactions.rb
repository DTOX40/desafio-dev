class CreateCnabTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :cnab_transactions do |t|
      t.integer :type_transaction, default: 1
      t.date :date_transaction
      t.float :value
      t.string :cpf
      t.string :card_number
      t.time :hour_transaction

      t.timestamps
    end
  end
end
