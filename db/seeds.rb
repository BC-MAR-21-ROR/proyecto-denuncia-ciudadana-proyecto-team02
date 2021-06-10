# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# rails -T db           # => I can see every task for database
# rails db:seed:replant # =>
# The difference with db:reset you can execute with server running, because delete registre not database and run seeds
# rails db:truncate_all # =>
# The difference with db:destroy you can execute with server running because delete registre not database

# WE WANT DENOUNCES A
p "Generating main user test...!"
user = FactoryBot.create(:user, username: 'test', email: 'test@gmail.com', password: 'test1234', password_confirmation: 'test1234')

p "Generating randoms denounces...!"
denounces = FactoryBot.create_list(:denounce, 10, user: user)
