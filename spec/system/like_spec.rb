require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  before do
    driven_by(:selenium)
  end

  let :user do
    FactoryBot.create(:user)
  end

  context 'when user is logged in' do
    it 'can like and unlinke denounces', js: true do
      denounce = FactoryBot.create(:denounce)
      login(as: user)

      click_link("create-like-#{denounce.id}")
      expect(page).to have_selector("#destroy-like-#{denounce.id}")

      click_link("destroy-like-#{denounce.id}")
      expect(page).to have_selector("#create-like-#{denounce.id}")
    end
  end

  context 'when the user is not logged' do
    it "can't like denounces" do
      denounce = FactoryBot.create(:denounce)
      visit('/')
      click_link("create-like-#{denounce.id}")

      expect(page).to have_content(/You need to sign in/)
    end
  end
end
