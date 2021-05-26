class AddAddressRelationShipWithDenounce < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :denounce
  end
end
