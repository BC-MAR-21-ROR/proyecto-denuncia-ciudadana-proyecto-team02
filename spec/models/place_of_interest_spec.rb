require 'rails_helper'

RSpec.describe PlaceOfInterest, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    subject { build(:place_of_interest) }

    it { should validate_presence_of(:postal_code) }
    it { should validate_presence_of(:settlement) }

    context 'Invalid presence' do
      it 'is not valid without a postal code' do
        subject.postal_code = nil
        expect(subject).to_not be_valid
      end

      it 'is not valid without a settlement ' do
        subject.settlement = nil
        expect(subject).to_not be_valid
      end
    end
  end
end
