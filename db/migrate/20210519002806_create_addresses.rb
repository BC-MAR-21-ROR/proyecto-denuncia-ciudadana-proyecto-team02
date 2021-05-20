class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :number
      t.string :street
      t.string :settlement
      t.string :postal_code
      t.string :municipality
      t.string :state

      t.timestamps
    end
  end
end
