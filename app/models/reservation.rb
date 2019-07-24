class Reservation < ApplicationRecord
  belongs_to :movie
  belongs_to :day
end
