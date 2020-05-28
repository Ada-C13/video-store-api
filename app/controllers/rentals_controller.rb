class RentalsController < ApplicationController
  def checkout
    new_video = Video.find_by(id: params[:video_id])
    new_customer = Customer.find_by(id: params[:customer_id])

    if new_video.nil? || new_video.available_inventory < 1 || new_customer.nil?
      render json: {
        errors: ['Not Found']
      }, status: :not_found
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
        status: :ok
        return
    else 
      render json: {
        errors: checkout.errors.messages
      }, 
        status: :bad_request
      return
    end
    
  end

  def checkin
    new_video = Video.find_by(id: params[:video_id])
    new_customer = Customer.find_by(id: params[:customer_id])
    checkin = Rental.find_by(customer: new_customer, video: new_video)

    if checkin.nil?
      render json: {
          errors: ['Not Found']
        }, status: :not_found
        return
    else
      render json: {
        customer_id: checkin.customer_id,
        customer_id: checkin.customer_id,
        video_id: checkin.video_id,
        videos_checked_out_count: checkin.decrement_videos_checked_out_count,
        available_inventory: checkin.increment_available_inventory
    }, 
      status: :ok
      return 
  end
end

  private

  def rental_params
    return params.permit(:customer_id, :video_id)
  end
end
