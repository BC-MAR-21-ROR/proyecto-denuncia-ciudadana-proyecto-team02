# == Schema Information
#
# Table name: denounces
#
#  id          :bigint           not null, primary key
#  anonymouse  :boolean
#  area        :integer
#  description :string
#  event_date  :date
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Denounce < ApplicationRecord
  enum area: %i[security services infrastructure theft bribery abuse transit]
  validates :area, :title, :description, presence: true
  belongs_to :user
  # belongs_to :address
end