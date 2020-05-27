require 'date'

class RentalsController < ApplicationController

  def index 
    rental = Rental.all
    render json: rental.as_json(except: [:id, :updated_at, :created_at]), status: :ok
  end 

  def check_out 
    video = Video.find_by(id: params[:video_id])
    customer = Customer.find_by(id: params[:customer_id])
    date = DateTime.now + 1.week
    rental = Rental.new(due_date: date, customer_id: customer.id, video_id: video.id)
  

    if customer.nil? || video.nil? 
      render json: {
        errors: [
            "Not Found"
          ]
        }, status: :not_found
      return
    end 
    
    video.reload
    customer.reload
    
    if Rental.inventory_check_out(rental)
        if rental.save 
          video.reload
          customer.reload
          render json: {
            customer_id: rental.customer_id,
            video_id: rental.video_id,
            due_date: rental.due_date,
            videos_checked_out_count: customer.videos_checked_out_count,
            available_inventory: video.available_inventory
          }, status: 200
          return 
         
        else
          render json: {
            "errors": [
                "Not Found"
              ]
            }, status: :not_found
          return
        end 
        
    end 
  end 

  def check_in 



  end 


end
