class RentalsController < ApplicationController


  def check_out  
    rental = Rental.new(rentals_params)
    video = Video.find_by(id: rentals_params[:video_id])
    customer = Customer.find_by(id: rentals_params[:customer_id])

    if customer.nil?
      render json: {errors: ["Not Found"] }, status: :not_found
      return
    end

    if video.available_inventory > 0
      rental.save

      video.available_inventory -= 1
      video.save

      customer.checked_out_count += 1
      customer.save
  end

  return rental
end


  
  def check_in 
  end

  def rentals_params
    return params.permit(:customer_id, :video_id)
  end
end


