FactoryBot.define do
  factory :cnab_transaction do
    type_transaction { 1 }
    date_transaction { Date.today }
    value { 100.0 }
    cpf { "12345678900" }
    card_number { "************1234" }
    hour_transaction { "12:34" }
    association :store, factory: :store
  end
end
