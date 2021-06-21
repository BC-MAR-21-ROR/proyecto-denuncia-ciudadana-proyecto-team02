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
    it { should define_enum_for(:area) }
    it { should have_one(:address).dependent(:destroy) }
    it { should accept_nested_attributes_for(:address).allow_destroy(true) }
    it { should have_many_attached(:medias) }
  end

  describe 'validations' do
    it { should validate_presence_of(:area) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { is_expected.to validate_size_of(:medias).less_than(10.megabytes) }
  end

  describe '#attached media' do
    subject { create(:denounce).medias }
    it { is_expected.to be_an_instance_of(ActiveStorage::Attached::Many) }
  end
end
