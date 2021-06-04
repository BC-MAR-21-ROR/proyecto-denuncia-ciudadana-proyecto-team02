# == Schema Information
#
# Table name: states
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class State < ApplicationRecordAws
  has_many :municipalities
  has_many :settlements, through: :municipalities

  def self.names
    order(name: :asc).pluck(:name)
  end
end
