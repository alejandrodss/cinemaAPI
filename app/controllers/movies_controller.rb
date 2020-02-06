class MoviesController < ApplicationController
  def index
    movies = if params[:day]
      Movie.joins(:days).where("days.name = '#{params[:day]}'")
    else
      Movie.all
    end
    render json: movies, status: :ok
  end

  def create
    return render(json: { message: "La película ya ha sido agregada"}, status: :bad_request) if Movie.find_by(name: params[:name])
    movie = Movie.create(create_params)
    add_days(movie)
    render json: {
      message: "La película #{movie.name} ha sido agregada exitosamente",
      id: movie.id,
      name: movie.name
    }, status: :created
  end

  private

  def create_params
    params.permit(:name, :description, :image_url)
  end

  def add_days(movie)
    days = params[:days].map do |code|
      Day.find_by(code: code).id
    end
    movie.day_ids = days
  end
end
