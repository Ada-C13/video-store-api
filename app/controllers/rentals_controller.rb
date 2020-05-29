class RentalsController < ApplicationController
  def checkout
    new_rental = Rental.new(rentals_params)
    new_rental.checkout_date = Date.today
    new_rental.due_date = Date.today + 7.days
    new_rental.return_date = nil



    if new_rental.save
      video = new_rental.video
      if video.available_inventory <= 0
        render json: {
          errors: new_rental.errors.messages
        }, status: :not_found
        return
      else
        video.available_inventory -= 1
        video.save
        available_inventory = new_rental.video.available_inventory
      end

      customer = new_rental.customer
      customer.videos_checked_out_count += 1
      customer.save
      videos_checked_out_count = new_rental.customer.videos_checked_out_count

      rental_view = new_rental.as_json(only: [:customer_id, :video_id, 
        :due_date])
      rental_view[:videos_checked_out_count] = videos_checked_out_count
      rental_view[:available_inventory] = available_inventory

      render json: rental_view, 
        status: :ok
    else
      render json: {
        errors: new_rental.errors.messages
      }, status: :bad_request
      return
    end
  end

  def checkin
    rental = Rental.find_by(video_id: params[:video_id], customer_id: params[:customer_id], return_date: nil)

    if rental
      video = rental.video
      video.available_inventory += 1
      video.save
      available_inventory = rental.video.available_inventory

      customer = rental.customer
      if customer.videos_checked_out_count <= 0
        render json: {
          errors: rental.errors.messages
        }, status: :not_found
        return
      else
        customer.videos_checked_out_count -= 1
        customer.save
        videos_checked_out_count = rental.customer.videos_checked_out_count
      end

      rental.return_date = Date.today
      puts rental.return_date

      rental_view = rental.as_json(only: [:customer_id, :video_id])
      rental_view[:videos_checked_out_count] = videos_checked_out_count
      rental_view[:available_inventory] = available_inventory

      render json: rental_view, 
        status: :ok
    else
      render json: {
        errors: rental.errors.messages
      }, status: :not_found
      return
    end
  end

  private

  def rentals_params
    return params.permit(:customer_id, :video_id)
  end
end
