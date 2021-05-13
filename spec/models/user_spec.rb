# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string           default("citizen"), not null
#  unconfirmed_email      :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#username' do
    it 'must be unique' do
      FactoryBot.create(:user, username: 'jane')
      user = FactoryBot.build(:user, username: 'jane')

      expect(user).to be_invalid
      expect(user.errors[:username]).to include('has already been taken')
    end

    it 'must be alphanumeric' do
      user = FactoryBot.build(:user, username: 'john_smith')

      expect(user).to be_invalid
      expect(user.errors[:username]).to include('must be alphanumeric')
    end
  end

  describe '#password' do
    it 'must be alphanumeric' do
      user = FactoryBot.build(:user, password: 'invalid_password')

      expect(user).to be_invalid
      expect(user.errors[:password]).to include('must be alphanumeric')
    end
  end
end
