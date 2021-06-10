require 'rails_helper'

RSpec.describe 'Denounce', type: :system do
  before do
    driven_by(:selenium)
  end

  let :user do
    FactoryBot.create(:user)
  end

  let :denounce do
    FactoryBot.create(:denounce, title: 'Laudantium dicta illo', user: user)
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
      denounce
      login(as: user)
      visit('/denounces')
      find('#accordionDenounces .accordion-item .bi.bi-eye').click
      expect(page).to have_content('Laudantium dicta illo')
    end
  end

  describe 'Edit denounce' do
    before do
      denounce
      login(as: user)
      visit('/denounces')
    end
    it 'successfully update title of denounce' do
      find('#accordionDenounces .accordion-item .bi.bi-pencil').click
      expect(page).to have_content(/Event date/)
      fill_in 'denounce_title', with: 'x Laudantium dicta'
      click_on 'Save'
      expect(page).to have_content(/successfully updated/)
    end
    it 'fail update title of denounce' do
      find('#accordionDenounces .accordion-item .bi.bi-pencil').click
      expect(page).to have_content(/Event date/)
      fill_in 'denounce_title', with: nil
      click_on 'Save'
      expect(page).to have_content(/couldn't be updated/)
    end
  end

  describe 'Destroy denounce' do
    it 'clicking trash icon of a denounce must destroy it' do
      denounce
      login(as: user)
      visit('/denounces')
      find('#accordionDenounces .accordion-item .bi.bi-trash').click
      accept_alert { 'Are you sure?' }
      expect(page).to have_content(/successfully destroyed/)
    end
  end

  describe 'Create denounce' do
    context 'when a new denounce is created' do
      it 'success message is shown' do
        login(as: user)
        visit('/denounces')
        click_on('Add new Denounce')
        select '2021', from: 'denounce_event_date_1i'
        select 'May', from: 'denounce_event_date_2i'
        select '3', from: 'denounce_event_date_3i'
        select '23', from: 'denounce_event_date_4i'
        select '43', from: 'denounce_event_date_5i'
        select 'security', from: 'Area'
        fill_in 'Title', with: 'Laudantium dicta'
        fill_in 'Description', with: 'Laudantium dicta'
        fill_in 'Street', with: 'Avenida Andalucia'
        fill_in 'Number', with: '10'
        select 'Colima', from: 'State'
        select 'Colima', from: 'Municipality'
        select 'Las Palmas', from: 'Settlement'
        click_on('Save')
        expect(page).to have_content(/successfully created/)
      end
    end
    context "when a new denounce can't be created" do
      it 'fail message is shown' do
        login(as: user)
        visit('/denounces')
        click_on('Add new Denounce')
        select 'Colima', from: 'State'
        select 'Colima', from: 'Municipality'
        select 'Las Palmas', from: 'Settlement'
        click_on('Save')
        expect(page).to have_content(/couldn't be created/)
      end
    end
  end
end
