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
  end

  describe 'validations' do
    subject { build(:denounce) }

    it { should validate_presence_of(:area) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    # it { should validate_presence_of(:anonymouse) }

    context 'Invalid presence' do
      it 'is not valid without a title' do
        subject.title = nil
        expect(subject).to_not be_valid
      end

      it 'is not valid without an area' do
        subject.area = nil
        expect(subject).to_not be_valid
      end

      it 'is not valid without a description' do
        subject.description = nil
        expect(subject).to_not be_valid
      end

      # xit 'is not valid without a anonymouse option' do
      #   subject.anonymouse = nil
      #   expect(subject).to_not be_valid
      # end
    end
  end
end
