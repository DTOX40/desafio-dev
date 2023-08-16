class CnabTransaction < ApplicationRecord
  enum type_transaction: {
    debit: 1,
    billet: 2,
    financing: 3,
    credit: 4,
    loan_receipt: 5,
    sales: 6,
    ted_receipt: 7,
    doc_receipt: 8,
    rent: 9
  }

  validates :type_transaction, :date_transaction, :value, :cpf, :card_number, :hour_transaction, presence: true
  belongs_to :store

  before_create :update_store_balance

  private

  def update_store_balance
    case type_transaction
    when "debit", "credit", "loan_receipt", "sales", "ted_receipt", "doc_receipt"
      store.balance += value
    when "billet", "financing", "rent"
      store.balance -= value
    else
      store.balance += value
    end

    store.save
  end
end
