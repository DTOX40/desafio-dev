require 'rails_helper'

RSpec.describe CnabTransaction, type: :model do
  describe "validations" do
    it { should validate_presence_of(:type_transaction) }
    it { should validate_presence_of(:date_transaction) }
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:cpf) }
    it { should validate_presence_of(:card_number) }
    it { should validate_presence_of(:hour_transaction) }
    it { should belong_to(:store) }
  end

  describe "enums" do
    it { should define_enum_for(:type_transaction).with_values(debit: 1, billet: 2, financing: 3, credit: 4, loan_receipt: 5, sales: 6, ted_receipt: 7, doc_receipt: 8, rent: 9) }
  end

  describe "associations" do
    it { should belong_to(:store) }
  end

  describe "before_create callback" do
    it "updates store balance for debit transaction" do
      store = create(:store)
      cnab_transaction = build(:cnab_transaction, type_transaction: "debit", store: store)
      expect { cnab_transaction.save }.to change { store.reload.balance }.by(cnab_transaction.value)
    end

    it "updates store balance for credit transaction" do
      store = create(:store)
      cnab_transaction = build(:cnab_transaction, type_transaction: "credit", store: store)
      expect { cnab_transaction.save }.to change { store.reload.balance }.by(cnab_transaction.value)
    end

    it "updates store balance for other transactions" do
      store = create(:store)
      cnab_transaction = build(:cnab_transaction, type_transaction: "billet", store: store)
      expect { cnab_transaction.save }.to change { store.reload.balance }.by(-cnab_transaction.value)
    end
  end
end
