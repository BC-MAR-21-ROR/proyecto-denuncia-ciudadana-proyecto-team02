require 'rails_helper'

RSpec.describe 'Denounce', type: :system do
  before do
    driven_by(:selenium)
  end

  let :user do
    FactoryBot.create(:user)
  end
  describe 'accessing my denounces' do
    context 'when user is not signed in' do
      it 'redirects to sign in' do
        visit('/')
        click_on('My denounces')
        expect(page).to have_content(/You need to sign in/)
      end
    end
    context 'when user is signed in' do
      it 'list my denounces' do
        FactoryBot.create_list(:denounce, 6, user: user)
        login(as: user)
        click_on('My denounces')
        expect(page).to have_selector('#accordionDenounces .accordion-item', count: 6)
      end
    end
  end
end
