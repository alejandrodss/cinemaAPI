# CINEMA API

A Cinema API app made with rails

* Ruby version: 2.6.3
* Rails version: 5.2

The app uses docker and docker-compose to run on local environment.

## Configuration
To setup and start application run:
```bash
sudo docker-compose run web bundle install
```
```bash
sudo docker-compose run web bin/rails db:create
```
```bash
sudo docker-compose run web bin/rails db:migrate
```
```bash
sudo docker-compose up
```
That's all

## Testing
The project uses RSpec for unit testing.
For execute test suite run:
```bash
sudo docker-compose run web bin/rails db:test:prepare
```
```bash
sudo docker-compose run web bundle exec rspec spec/
```
## Endpoints availables
* GET/movies
> Get a list of current movies
* POST/movies
> Create a new Movie, the needed data is name, description, image_url and scheduled days
* GET/reservations
> Get a list of current reservations
* POST/reservations
> Make a movie reservation, the data that you need is movie_id, day_id, name, identification_number, email, phone
