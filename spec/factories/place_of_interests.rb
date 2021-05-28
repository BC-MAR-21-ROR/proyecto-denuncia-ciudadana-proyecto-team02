FactoryBot.define do
  factory :place_of_interest do
    settlement { Faker::Address.street_address }
    postal_code { Faker::Address.postcode }
    user
  end
end
