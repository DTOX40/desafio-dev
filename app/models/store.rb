class Store < ApplicationRecord
  has_many :cnab_transactions
  validates :name, :owner_name, presence: true
end
