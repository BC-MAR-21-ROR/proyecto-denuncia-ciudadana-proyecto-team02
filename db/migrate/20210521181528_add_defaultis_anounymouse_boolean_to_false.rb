class AddDefaultisAnounymouseBooleanToFalse < ActiveRecord::Migration[6.1]
  def change
    change_column_default :denounces, :anonymouse, false
  end
end
