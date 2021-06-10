# t.string :number
# t.string :street
# t.string :settlement
# t.string :postal_code
# t.string :municipality
# t.string :state
#
# t.timestamps
# <Address id: 3, number: nil, street: nil,
# settlement: "Machado Sur",
# postal_code: "22703", municipality: "Playas de Rosarito",
# state: "Baja_California", created_at: "2021-05-26 15:31:41.616405000 +0000",
# updated_at: "2021-05-26 15:31:41.616405000 +0000", denounce_id: 14>
FactoryBot.define do
  factory :address do
    street { Faker::Address.street_name }
    number { Faker::Address.building_number }
    state { State.all.sample.name }
    municipality { State.find_by(name: state).municipalities.sample.name }
    settlement { Municipality.find_by(name: municipality).settlements.sample.name }
    postal_code { Settlement.find_by(name: settlement).postal_code }
    denounce
  end
end
