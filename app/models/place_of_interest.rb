class PlaceOfInterest < ApplicationRecord
  validates :postal_code, :settlement, presence: true
  belongs_to :user
end
