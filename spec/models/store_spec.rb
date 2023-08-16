require 'rails_helper'

RSpec.describe Store, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:owner_name) }
  end

  describe "#update_balance" do
    it "updates the store balance based on the sum of transaction values" do
      store = create(:store)
      cnab_transactions = [
        create(:cnab_transaction, value: 100.0, store: store),
        create(:cnab_transaction, value: 50.0, store: store),
        create(:cnab_transaction, value: -30.0, store: store),
        create(:cnab_transaction, value: 20.0, store: store)
      ]

      store.update_balance

      expected_balance = cnab_transactions.sum(&:value)
      expect(store.reload.balance).to eq(expected_balance)
    end
  end
end
