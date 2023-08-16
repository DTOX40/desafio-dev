class Store < ApplicationRecord
  has_many :cnab_transactions
  validates :name, :owner_name, presence: true

  def update_balance
    update(balance: cnab_transactions.sum(:value))
  end
end
