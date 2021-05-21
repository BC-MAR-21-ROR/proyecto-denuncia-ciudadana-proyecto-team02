class CreateDenounces < ActiveRecord::Migration[6.1]
  def change
    create_table :denounces do |t|
      t.date :event_date
      t.integer :area
      t.string :title
      t.string :description
      t.integer :user_id
      t.boolean :anonymouse

      t.timestamps
    end
  end
end
