class RentalsController < ApplicationController
  
  def check_out 
    # creates new instance of rental 
    # needs cust id 
    # needs video id 
    # increase cust checked out count
    # decrease avail inventory 
    
    customer = Customer.find_by(id: params[:customer_id])
    video = Video.find_by(id: params[:video_id])
    
    rental = Rental.new(customer_id: customer.id, video_id: video.id)
    
    if rental.save
      #TODO update to show full response (customer_id, video_id, due_date, videos_checked_out_count, available_inventory)
      render json: rental.as_json(only: [:id]), status: :created
      return
    else
      render json: {
        ok: false,
        message: 'Did not create retnal'
        }, status: :bad_request
        return   
      end
      
    end 
    
    private
    
    def rental_params
      return params.require(:rental).permit(:customer_id, :video_id)
    end
    
  end
  