class RentalsController < ApplicationController

  def checkout
    customer = Customer.find_by(id: rental_params[:customer_id])
    video = Video.find_by(id: rental_params[:video_id])

    if customer.nil? || video.nil?
      render json: {
        errors: ['Not Found'],
      }, status: :not_found
      return
    end

    if !video.check_availability
      render json: {
        errors: ['No videos in stock'],
      }, status: :bad_request
      return
    end

    rental = Rental.new(customer_id: customer.id, video_id: video.id)
    if rental.save
      video.decrease_inventory
      customer.increase_videos_checked_out_count
      render json: {
        "customer_id": customer.id,
        "video_id": video.id,
        "videos_checked_out_count": customer.videos_checked_out_count,
        "available_inventory": video.available_inventory,
      }, status: :ok
    else
      render json: {
        errors: rental.errors.messages
      }, status: :bad_request
      return
    end
  end

  def checkin
  end

  private

  def rental_params
    return params.permit(:customer_id, :video_id)
  end
end
