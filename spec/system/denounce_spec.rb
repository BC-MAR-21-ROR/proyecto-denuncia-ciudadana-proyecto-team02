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

  describe 'Show denounce' do
    it 'displays denounce details' do
      FactoryBot.create(:denounce, title: 'Laudantium dicta illo', user: user)
      login(as: user)
      visit('/denounces')
      find('#accordionDenounces .accordion-item .bi.bi-eye').click
      expect(page).to have_content('Laudantium dicta illo')
    end
  end

  describe 'Edit denounce' do
    it 'successfully update title of denounce' do
      FactoryBot.create(:denounce, title: 'Laudantium dicta illo', user: user)
      login(as: user)
      visit('/denounces')
      find('#accordionDenounces .accordion-item .bi.bi-pencil').click
      expect(page).to have_content(/Event date/)
      fill_in 'denounce_title', with: 'x Laudantium dicta'
      click_on 'Save'
      expect(page).to have_content(/successfully updated/)
    end
    it 'fail update title of denounce' do
      FactoryBot.create(:denounce, title: 'Laudantium dicta illo', user: user)
      login(as: user)
      visit('/denounces')
      find('#accordionDenounces .accordion-item .bi.bi-pencil').click
      expect(page).to have_content(/Event date/)
      fill_in 'denounce_title', with: ''
      click_on 'Save'
      expect(page).to have_content(/couldn't be updated/)
    end
  end

  describe 'Destroy denounce' do
    it 'clicking trash icon of a denounce must destroy it' do
      FactoryBot.create(:denounce, title: 'Laudantium dicta illo', user: user)
      login(as: user)
      visit('/denounces')
      find('#accordionDenounces .accordion-item .bi.bi-trash').click
      accept_alert { 'Are you sure?' }
      expect(page).to have_content(/successfully destroyed/)
    end
  end
end
