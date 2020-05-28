class RentalsController < ApplicationController
  
  def checkout
    customer = Customer.find_by(id: params[:customer_id])
    video = Video.find_by(id: params[:video_id])

    new_rental = Rental.new(customer_id: customer.id, video_id: video.id)
    new_rental.checkout_date = Date.today
    new_rental.due_date = Date.today + 7.days
    new_rental.return_date = nil

    if new_rental.save
      new_rental.video.available_inventory -= 1
      available_inventory = new_rental.video.available_inventory

      new_rental.customer.videos_checked_out_count += 1
      videos_checked_out_count = new_rental.video.available_inventory


      render json: new_rental.as_json(only: [:customer_id, :video_id, 
        :due_date, videos_checked_out_count, available_inventory]), 
        status: :ok
    else
      render json: {
        errors: new_rental.errors.messages
      }, status: :bad_request
      return
    end
  end

  def checkin

  end

  private

  # def rentals_params
  #   return params.permit(:customer_id, :video_id)
  # end
end
