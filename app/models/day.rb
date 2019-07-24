class Day < ApplicationRecord
  has_many :movie_days
  has_many :movies, through: :movie_days
end
