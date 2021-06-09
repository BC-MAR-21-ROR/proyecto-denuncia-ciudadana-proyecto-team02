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

p "Generating randoms denounces for main user!"
denounces = FactoryBot.create_list(:denounce, 10, user: user_test)

p "Generating randoms places of interest for #{user_test.username}...!"
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

def create_seed(number)
  denounces = FactoryBot.create_list(:denounce, number)
  denounces.each { |denounce| FactoryBot.create_list(:like, rand(1..10), likeable: denounce) }
  User.limit(10).each { |user| FactoryBot.create_list(:place_of_interest, rand(1..10), user: user) }
end

thr = []
thr << Thread.new { create_seed(25) }
thr << Thread.new { create_seed(25) }
thr << Thread.new { create_seed(25) }
thr << Thread.new { create_seed(25) }
thr.each(&:join)
