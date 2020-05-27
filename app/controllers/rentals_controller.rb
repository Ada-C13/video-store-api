require 'date'

class RentalsController < ApplicationController

  def check_out 
    video = Video.find_by(id: params[:video_id])
    customer = Customer.find_by(id: params[:customer_id])
    date = DateTime.now + 1.week
    rental = Rental.new(due_date: date, customer_id: customer.id, video_id: video.id)

    
    if Rental.inventory_check_out(rental)
      if rental.save 
        render json: rental.as_json(except: [:created_at, :updated_at]), status: :created
        return 
      else
        render json: {
          "errors": "Invalid customer or video ID"
          }, status: :bad_request
        return
      end 
    else
      render json: {
        "errors": "No Inventory Available"
        }, status: :bad_request
      return 
    end 
  end 

  def check_in 



  end 


end
