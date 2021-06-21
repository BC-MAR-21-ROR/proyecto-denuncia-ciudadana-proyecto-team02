# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# rails -T db           # => I can see every task for database
# rails db:seed:replant # =>
# The difference with db:reset you can execute with server running, because delete registre not database and run seeds
# rails db:truncate_all # =>
# The difference with db:destroy you can execute with server running because delete registre not database

# USER_TEST
p "Generating main user test...!"
user_test = FactoryBot.create(
  :user,
  username: 'test',
  email: 'test@gmail.com',
  password: 'test1234',
  password_confirmation: 'test1234'
)

p 'Generating random denounces for main user!'
denounces = FactoryBot.create_list(:denounce, 10, user: user_test)

p 'Generaring random attachment for main user!'
denounces.each do |denounce|
  files = ['unsplash.jpeg', 'unsplash_1.jpeg', 'unsplash_2.jpeg', 'file.pdf', 'file_1.pdf']
  files.sample(rand(0..5)).each do |file|
    denounce.medias.attach(io: File.open("app/assets/attachments/#{file}"), filename: file)
  end
end

p "Generating random places of interest for #{user_test.username}...!"
denounces.each do |denounce|
  current_address = denounce.address
  FactoryBot.create(
    :place_of_interest,
    user: user_test,
    settlement: current_address.settlement,
    postal_code: current_address.postal_code
  )
end

# GENERATE MORE TEST

def create_users(number)
  FactoryBot.create_list(:user, number)
end

def create_denunce(users)
  users.map do |user|
    FactoryBot.create_list(:denounce, rand(1..5), user: user)
  end.flatten
end

def create_places_of_interest(users)
  Denounce.all.sample(10).each do |denounce|
    current_address = denounce.address
    FactoryBot.create(
      :place_of_interest,
      user: users.sample,
      settlement: current_address.settlement,
      postal_code: current_address.postal_code
    )
  end
end

def create_likes_random(users)
  users.each do |user|
    Denounce.all.sample(10).each do |denounce|
      FactoryBot.create(:like, likeable: denounce, user: user)
    end
  end
end

def create_seeds(number)
  print '.'
  u = create_users(number)
  create_denunce(u)
  create_places_of_interest(u)
  create_likes_random(u)
  print '.'
end

thr = []
thr << Thread.new { create_seeds(10) }
thr << Thread.new { create_seeds(10) }
thr << Thread.new { create_seeds(10) }
thr << Thread.new { create_seeds(10) }
thr.each(&:join)
