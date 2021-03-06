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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :username, format: { with: /\A[A-Za-z0-9]+\z/, message: 'must be alphanumeric' },
                       presence: true,
                       uniqueness: true
  validates :password, format: { with: /\A[A-Za-z0-9]+\z/, message: 'must be alphanumeric' },
                       presence: true,
                       if: :password
  has_many :denounces
  has_many :place_of_interest
  has_many :likes, dependent: :destroy

  def like?(likeable)
    likes.find_by(likeable_id: likeable.id, likeable_type: likeable.class.name)
  end

  def postal_codes_by_place_of_interest
    place_of_interest.pluck(:postal_code)
  end
end
