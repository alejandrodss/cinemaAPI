class MovieDay < ApplicationRecord
  belongs_to :movie
  belongs_to :day
end
