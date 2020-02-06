class ReservationsController < ApplicationController
  def index
    reservations = Reservation.all
    render json: reservations, status: :ok
  end

  def create
    seats_count = Reservation.where(movie_id: params[:movie_id], day_id: params[:day_id]).count
    if seats_count < 10
      if Reservation.create(create_params)
        render json: { message: "Reserva exitosa"}, status: :created
      else
        render json: { message: "Hubo un error al realizar la reserva"}, status: :bad_request
      end
    else
      render json: { message: "La sala ya está llena"}, status: :bad_request
    end
  end

  private
  def create_params
    params.permit(:movie_id, :day_id, :name, :identification_number, :email, :phone)
  end
end
