require 'rails_helper'

RSpec.describe 'Authentication', type: :system do
  before do
    driven_by(:selenium)
  end

  let :user do
    FactoryBot.create(:user)
  end

  describe 'sign_up' do
    it 'success but requires email confirmation' do
      user = FactoryBot.attributes_for(:user).slice(:username, :email, :password)

      signup(username: user[:username], email: user[:email], password: user[:password])

      expect(page).to have_content(/A message with a confirmation link has been sent/)
    end
  end

  describe 'sign_in' do
    it "fails when user doesn't exist" do
      login(email: 'capybaraerror@example.com', password: 'password')

      expect(page).to have_content('Invalid Email or password')
    end

    it 'require email confirmation' do
      user = FactoryBot.create(:user, confirmed_at: nil)

      login(as: user)

      expect(page).to have_content(/You have to confirm your email address/)
    end

    it 'success with valid user credentials' do
      login(as: user)

      expect(page).to have_content('Signed in successfully')
    end
  end

  describe 'sign_out' do
    it 'destroy session when clicking in link out' do
      login(as: user)
      logout
      expect(page).to have_content('Signed out successfully')
    end
  end
end
