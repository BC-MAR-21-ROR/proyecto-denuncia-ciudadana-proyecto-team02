# Setup

## Integrantes

- Angelina Moreno [Anxhe](https://github.com/anxhe)
- Roberto Velazco [RoberVel666](https://github.com/RoberVel666)
- Miguel Rodriguez [Arkamis](https://github.com/Arkamis)
- Eusebio Ajas [EusebioAjas](htpps://github.com/EusebioAjas)


## Setup locally


Install dependencies:

`bundle install` & `yarn install`

To create and adjust database:

- (Optional) Copy docker-compose.yml.example as docker-compose.yml
  - run `docker compose up` to run postgres

- Create and adjust config/database.yml
  - Based on config/database.yml.example
  - then `rake db:setup` to setup database
  - finally `rails dbconsole`

Execute project with: `rails server` and `bin/webpack-dev-server`

### Run Tests
>Execute  RSpec  tests with: `rspec ./spec -f d`


### :information_source: App Demo
:link:[You can see the app demo up & running.🚀](https://thawing-everglades-48094.herokuapp.com/)
