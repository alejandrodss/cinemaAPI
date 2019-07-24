class MoviesController < ApplicationController
  def index
    movies = if params[:day]
      Movie.joins(:days).where("days.name = '#{params[:day]}'")
    else
      Movie.all
    end
    render json: movies, status: :ok
  end
end
