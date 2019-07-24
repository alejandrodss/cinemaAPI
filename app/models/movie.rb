class Movie < ApplicationRecord
  has_many :movie_days
  has_many :days, through: :movie_days
  has_many :reservations
end
