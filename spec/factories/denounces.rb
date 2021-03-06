# == Schema Information
#
# Table name: denounces
#
#  id          :bigint           not null, primary key
#  anonymouse  :boolean          default(FALSE)
#  area        :integer
#  description :string
#  event_date  :datetime
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
FactoryBot.define do
  factory :denounce do
    event_date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    title { Faker::Lorem.sentence(word_count: 3) }
    area { Faker::Number.between(from: 0, to: 6) }
    description { Faker::Lorem.paragraph }
    anonymouse { [true, false].sample }
    user
    address { association :address, denounce: instance }

    trait :with_medias do
      after(:create) do |denounce|
        file_path = Rails.root.join('app', 'assets', 'attachments', 'unsplash.jpeg')
        denounce.medias.attach(io: File.open(file_path), filename: 'unsplash.jpeg', content_type: 'image/jpeg')
      end
    end
  end
end
