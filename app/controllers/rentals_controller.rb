class RentalsController < ApplicationController
  def checkout
    new_video = Video.find_by(id: params[:video_id])
    
    if new_video.nil? || new_video.available_inventory < 1 
      render json: {
        errors: "No available inventory"
      }, status: :bad_request
      return
    end

    checkout = Rental.new(rental_params)
    checkout.due_date = Date.today + 7.days

    
    if checkout.save
      render json: {
          customer_id: checkout.customer_id,
          video_id: checkout.video_id,
          due_date: checkout.due_date,
          videos_checked_out_count: checkout.customer.videos_checked_out_count,
          available_inventory: checkout.video.available_inventory
      }, 
        status: :created
        return
    else 
      render json: {
        ok: false,
        errors: checkout.errors.messages
      }, 
        status: :bad_request
      return
    end
    
  end

  private

  def rental_params
    return params.permit(:customer_id, :video_id)
  end
end
