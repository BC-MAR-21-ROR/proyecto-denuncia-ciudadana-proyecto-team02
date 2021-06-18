# == Schema Information
#
# Table name: denounces
#
#  id          :bigint           not null, primary key
#  anonymouse  :boolean          default(FALSE)
#  area        :integer
#  description :string
#  event_date  :datetime
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Denounce < ApplicationRecord
  enum area: %i[security services infrastructure theft bribery abuse transit]
  validates :area, :title, :description, presence: true
  validates :medias, content_type: %i[png jpg jpeg pdf]
  validates :medias, size: { less_than: 10.megabytes , message: 'is not given between size' }
  validates :medias, limit: { min: 1, max: 5 }
  belongs_to :user
  has_one :address, dependent: :destroy
  has_many_attached :medias, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true
  has_many :likes, as: :likeable, dependent: :destroy

  scope :for_postal_code, ->(postal_codes) { joins(:address).where(address: { postal_code: postal_codes }) }
end
