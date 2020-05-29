class RentalsController < ApplicationController
  def checkout
    video = Video.find_by(id: params[:video_id])
    customer = Customer.find_by(id: params[:customer_id])

    # check video and customer exists
    if video.nil? || customer.nil? 
      render json: {errors: ['Not Found']}, status: :not_found
      return
    end

    # check video is available
    if video.available_inventory > 0
      new_rental = Rental.new(rental_params)
      
      if new_rental.save
        # new_rental.decrease_inventory
        video.available_inventory -= 1
        video.save

        # new_rental.increase_videos_checked_out_count
        customer.videos_checked_out_count += 1
        customer.save

        # render json object 
        render json: {
          customer_id: customer.id, 
          video_id: video.id, 
          due_date: Date.today + 7,
          videos_checked_out_count: customer.videos_checked_out_count,
          available_inventory: video.available_inventory,
        } , status: :ok
        return
      end

    else
      render json: {errors: ["Video currently not available"]}, status: :bad_request
    end
  end

  def checkin
    
  end 
end


private

def rental_params
  params.permit(:video_id, :customer_id)
end