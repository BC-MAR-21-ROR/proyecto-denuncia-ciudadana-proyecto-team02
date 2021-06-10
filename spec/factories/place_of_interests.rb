FactoryBot.define do
  factory :place_of_interest do
    user
    settlement { Faker::Address.community }
    postal_code { Faker::Address.postcode }
  end
end
