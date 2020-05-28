class RentalsController < ApplicationController
  def create
    rental = Rental.new(rental_params)

    if rental.save
      rental.customer.videos_checked_out_count += 1
      rental.customer.save
      rental.video.available_inventory -= 1
      rental.video.save
      
      render json: {
        customer_id: rental.customer_id,
        video_id: rental.video_id,
        due_date: rental.due_date,
        videos_checked_out_count: rental.customer.videos_checked_out_count,
        available_inventory: rental.video.available_inventory
      }, status: :ok
    else
      render json: {
          ok: false,
          errors: rental.errors.messages
        }, status: :bad_request
    end
  end

  private

  def rental_params
    return params.permit(:video_id, :customer_id)
  end

  # def require_customer
  #   @customer = Customer.find_by()
end
