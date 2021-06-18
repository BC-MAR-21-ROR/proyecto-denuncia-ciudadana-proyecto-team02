require 'rails_helper'

RSpec.describe 'evidence', type: :system do
  before do
    driven_by(:selenium)
  end

  let :user do
    FactoryBot.create(:user)
  end

  let(:denounce) { create :denounce, :with_medias, user: user }

  context 'when a denounce is created with an attached evidence' do
    describe 'edit denounce' do
      it 'can destroy evidence' do
        denounce
        login(as: user)
        visit("/denounces/#{denounce.id}/edit")
        first('.btn-link .bi-trash').click
        accept_alert { 'Are you sure?' }
        expect(page).to have_content(/successfully deleted/)
      end
    end
  end
end
