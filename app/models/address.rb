# == Schema Information
#
# Table name: addresses
#
#  id            :bigint           not null, primary key
#  number        :string
#  street        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  settlement_id :bigint           not null
#
# Indexes
#
#  index_addresses_on_settlement_id  (settlement_id)
#
# Foreign Keys
#
#  fk_rails_...  (settlement_id => settlements.id)
#
class Address < ApplicationRecord
  belongs_to :settlement
end
