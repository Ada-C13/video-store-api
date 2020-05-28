class RentalsController < ApplicationController
  def index
    rentals = Rental.all
    render json: rentals.as_json(), status: :ok
  end
end