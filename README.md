# README

A Cinema API app made with rails

* Ruby version: 2.6.3
* Rails version: 5.2

The app uses docker and docker-compose to run on local environment.

To setup and start application run:
* sudo docker-compose run web bundle install
* sudo docker-compose run web bin/rails db:create
* sudo docker-compose run web bin/rails db:migrate
* sudo docker-compose up

For execute test
* sudo docker-compose run web bin/rails db:test:prepare
* sudo docker-compose run web bundle exec rspec spec/
