require 'rails_helper'

RSpec.describe ReservationsController, type: :request do
  let(:movie1) { Movie.create(name: "Star Wars", description: "Una historia ocurrida en la galaxia", image_url: "https://starwars.com") }
  let(:movie2) { Movie.create(name: "El señor de los anillos", description: "El anillo unico", image_url: "https://lordoftherings.com") }
  let(:movie3) { Movie.create(name: "Harry Potter", description: "Los magos de Hogwarts", image_url: "https://harrypotter.com") }

  let(:day1) { Day.create(name: "Viernes") }
  let(:day2) { Day.create(name: "Domingo") }

  before do
    MovieDay.create(day_id: day1.id, movie_id: movie2.id)
    MovieDay.create(day_id: day2.id, movie_id: movie3.id)
    MovieDay.create(day_id: day1.id, movie_id: movie1.id)
    MovieDay.create(day_id: day2.id, movie_id: movie2.id)
  end

  describe "POST/reservations" do
    it "Create a reservation" do
      post "/reservations", params: { movie_id: movie2.id, day_id: day2.id, name: "Pablo", identification_number: 531902, email: "pablo@mail.com", phone: 300504 }
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Reserva exitosa")
      expect(Reservation.all.count).to eq(1)
    end
  end
  describe "GET/reservations" do
    it "List all reservations" do
      rev1 = Reservation.create(movie_id: movie1.id, day_id: day2.id, name: "Maria", identification_number: 8642091, email: "maria@mail.com", phone: 77522)
      rev2 = Reservation.create(movie_id: movie3.id, day_id: day1.id, name: "Paula", identification_number: 8742098, email: "paula@mail.com", phone: 99535)
      get "/reservations"
      json = JSON.parse(response.body)
      expect(json.size).to eq(2)
      expect(json).to match_array([{"id"=>rev1.id, "movie_id"=>movie1.id, "day_id"=>day2.id, "identification_number"=>8642091, "name"=>"Maria", "email"=>"maria@mail.com", "phone"=>77522},
        {"id"=>rev2.id, "movie_id"=>movie3.id, "day_id"=>day1.id, "identification_number"=>8742098, "name"=>"Paula", "email"=>"paula@mail.com", "phone"=>99535}])
    end
  end
end
