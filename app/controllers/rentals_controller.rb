class RentalsController < ApplicationController
  
  def checkout
    new_rental = Rental.new(rentals_params)
    new_rental.checkout_date = Date.now
    new_rental.due_date = Date.now + 7
    if video.save
      render json: video.as_json(only: [:id]), status: :created #201
    else
      render json: {
        errors: video.errors.messages
      }, status: :bad_request
      return
    end
    # raise
    # increase the customer's videos_checked_out_count by one
    # decrease the video's available_inventory by one
    # create a due date. The rental's due date is the seven days from the current date.

    # Request Body Param	Type	Details
    # customer_id	integer	ID of the customer attempting to check out this video
    # video_id	integer	ID of the video to be checked out
  end

  def checkin

  end

  private

  def rentals_params
    return params.require(:rentals).permit(:customer_id, :movie_id)
  end
end
