FactoryBot.define do
  factory :store do
    name { Faker::Company.name }
    owner_name { Faker::Name.name }
    balance { Faker::Number.decimal(l_digits: 2) }
  end
end
