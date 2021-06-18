class ChangeDateToDatetime < ActiveRecord::Migration[6.1]
  def change
    change_column(:denounces, :event_date, :datetime)
  end
end
