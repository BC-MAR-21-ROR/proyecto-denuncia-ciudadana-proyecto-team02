class CreatePlaceOfInterests < ActiveRecord::Migration[6.1]
  def change
    create_table :place_of_interests do |t|
      t.integer :postal_code, limit: 6, null: false
      t.string :settlement, limit: 50, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
