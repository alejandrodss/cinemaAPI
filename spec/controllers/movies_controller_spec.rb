require 'rails_helper'

RSpec.describe MoviesController, type: :request do
  let(:movie1) { Movie.create(name: "Star Wars", description: "Una historia ocurrida en la galaxia", image_url: "https://starwars.com") }
  let(:movie2) { Movie.create(name: "El señor de los anillos", description: "El anillo unico", image_url: "https://lordoftherings.com") }
  let(:movie3) { Movie.create(name: "Harry Potter", description: "Los magos de Hogwarts", image_url: "https://harrypotter.com") }

  let(:day1) { Day.find_by(code: "F") }
  let(:day2) { Day.find_by(code: "S") }

  before do
    MovieDay.create(day_id: day1.id, movie_id: movie2.id)
    MovieDay.create(day_id: day2.id, movie_id: movie3.id)
    MovieDay.create(day_id: day1.id, movie_id: movie1.id)
    MovieDay.create(day_id: day2.id, movie_id: movie2.id)
  end

  describe "GET/movies" do
    it "Get the all movies list" do
      get "/movies"
      json = JSON.parse(response.body)
      expect(json.size).to eq(3)
      expect(json).to match_array([{"id"=>movie2.id, "name"=>"El señor de los anillos", "description"=>"El anillo unico", "image_url"=>"https://lordoftherings.com"},
        {"id"=>movie3.id, "name"=>"Harry Potter", "description"=>"Los magos de Hogwarts", "image_url"=>"https://harrypotter.com"},
        {"id"=>movie1.id, "name"=>"Star Wars", "description"=>"Una historia ocurrida en la galaxia", "image_url"=>"https://starwars.com"}])
    end
    it "Get the all movies for a day" do
      get "/movies?day=Viernes"
      json = JSON.parse(response.body)
      expect(json.size).to eq(2)
      expect(json).to match_array([{"id"=>movie2.id, "name"=>"El señor de los anillos", "description"=>"El anillo unico", "image_url"=>"https://lordoftherings.com"},
        {"id"=>movie1.id, "name"=>"Star Wars", "description"=>"Una historia ocurrida en la galaxia", "image_url"=>"https://starwars.com"}])
    end
  end
  describe "POST/movies" do
    context "The movie is not scheduled yet" do
      it "Create a new movie" do
        post "/movies", params: { name: "X-Men", description: "a Mutants story", image_url: "https://portalgeek.co/wp-content/uploads/2019/09/XMEN.jpg", days: ["F", "S", "U"] }

        json = JSON.parse(response.body)
        expect(json["message"]).to eq("La película X-Men ha sido agregada exitosamente")
        expect(json["id"]).to eq(Movie.last.id)
        expect(json["name"]).to eq("X-Men")
      end
    end
    context "The movie is already scheduled" do
      it "Does not create a new movie" do
        movie = Movie.create(name: "X-Men", description: "A Mutants story", image_url: "https://portalgeek.co/wp-content/uploads/2019/09/XMEN.jpg")
        movie.day_ids = [day1.id]

        post "/movies", params: { name: "X-Men", description: "a Mutants story", image_url: "https://portalgeek.co/wp-content/uploads/2019/09/XMEN.jpg", days: ["F"] }

        json = JSON.parse(response.body)
        expect(json["message"]).to eq("La película ya ha sido agregada")
        expect(response.status).to eq(400)
      end
    end
  end
end
