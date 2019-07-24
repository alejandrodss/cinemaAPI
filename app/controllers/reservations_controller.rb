class ReservationsController < ApplicationController
  def index
    reservations = Reservation.all
    render json: reservations, status: :ok
  end

  def create
    if Reservation.create(create_params)
      render json: { message: "Reserva exitosa"}, status: :ok
    else
      render json: { message: "Hubo un error al realizar la reserva"}, status: :error
    end
  end

  private
  def create_params
    params.permit(:movie_id, :day_id, :name, :identification_number, :email, :phone)
  end
end
