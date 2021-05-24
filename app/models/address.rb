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
#
class Address < ApplicationRecord
  belongs_to :settlement
end
