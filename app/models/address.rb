# == Schema Information
#
# Table name: addresses
#
#  id           :bigint           not null, primary key
#  municipality :string
#  number       :string
#  postal_code  :string
#  settlement   :string
#  state        :string
#  street       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  denounce_id  :bigint
#
# Indexes
#
#  index_addresses_on_denounce_id  (denounce_id)
#
class Address < ApplicationRecord
  validates :state, :municipality, :postal_code, :settlement, presence: true
  belongs_to :denounce
end
