class CreateSettlements < ActiveRecord::Migration[6.1]
  def change
    create_table :settlements do |t|
      t.string :postal_code
      t.string :name
      t.references :municipality, null: false, foreign_key: true

      t.timestamps
    end
  end
end
