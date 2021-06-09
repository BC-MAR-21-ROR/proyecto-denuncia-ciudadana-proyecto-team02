# == Schema Information
#
# Table name: denounces
#
#  id          :bigint           not null, primary key
#  anonymouse  :boolean          default(FALSE)
#  area        :integer
#  description :string
#  event_date  :date
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
require 'rails_helper'

RSpec.describe Denounce, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_one(:address).dependent(:destroy) }
    it { should accept_nested_attributes_for(:address).allow_destroy(true) }
  end

  describe 'validations' do
    it { should validate_presence_of(:area) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_content_type_of(:medias).allowing( %i[jpg png jpeg pdf] ) }
    it { should validate_size_of(:medias).less_than(10.megabytes) }
  end
end
