class RentalsController < ApplicationController
  before_action :set_active_rental, only: [:check_in]

  def check_out
    @rental = Rental.new(rental_params)

    if Customer.find_by(id: rental_params[:customer_id]).nil? || Video.find_by(id: rental_params[:video_id]).nil?
      render json: { errors: ["Not Found"] }, status: :not_found
      return
    end

    if @rental.save
      response = { 
        customer_id: @rental.customer_id,
        video_id: @rental.video_id,
        due_date: @rental.due_date,
        videos_checked_out_count: @rental.customer.videos_checked_out_count,
        available_inventory: @rental.video.available_inventory
      }
      render json: response, status: :ok
    else
      render json: { errors: @rental.errors[:message] }, status: :not_found
    end
  end


  # POST /rentals/check-in
  def check_in 

    if Customer.find_by(id: rental_params[:customer_id]).nil? || Video.find_by(id: rental_params[:video_id]).nil?
      render json: { errors: ["Not Found"] }, status: :not_found
      return
    end

    if @rental
      @rental.returned_on = Time.now
      @rental.save!

      response = { 
        customer_id: @rental.customer_id,
        video_id: @rental.video_id,
        videos_checked_out_count: @rental.customer.videos_checked_out_count,
        available_inventory: @rental.video.available_inventory
      }
      render json: response, status: :ok
    else
      render json: { errors: @rental.errors }, status: :bad_request
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_active_rental
      @rental = Rental.find_by(customer_id: rental_params[:customer_id], video_id: rental_params[:video_id], returned_on: nil)
    end

    # Only allow a trusted parameter "white list" through.
    def rental_params
      params.permit(:customer_id, :video_id)
    end

end
