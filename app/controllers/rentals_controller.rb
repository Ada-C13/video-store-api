class RentalsController < ApplicationController
  
  def check_out 
    # creates new instance of rental 
    # needs cust id 
    # needs video id 
    # increase cust checked out count
    # decrease avail inventory 
    
    customer = Customer.find_by(id: rental_params[:customer_id])
    unless customer
      render json: { ok: false, message: 'Customer could not be found' }, status: :not_found
      return
    end
    
    
    video = Video.find_by(id: rental_params[:video_id])
    if video.nil?
      render json: { ok: false, message: 'Video could not be found' }, status: :not_found
      return
    end
    
    rental = Rental.new(customer_id: customer.id, video_id: video.id, due_date: Date.today + 7)
    
    if rental.save
      #TODO update to show full response (customer_id, video_id, due_date, videos_checked_out_count, available_inventory)
      render json: rental.as_json(except: [:id, :created_at, :updated_at]), status: :created
      return
    else
      render json: { ok: false, message: 'Did not create rental'}, status: :bad_request
      return   
    end
    
  end 
  
  private
  
  def rental_params
    return params.require(:rental).permit(:customer_id, :video_id)
  end
  
end
