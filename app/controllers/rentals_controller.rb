class RentalsController < ApplicationController

  def checkout 
    # increase the customer's videos_checked_out_count by one
    # decrease the video's available_inventory by one
    # create a due date. The rental's due date is the seven days from the current date.
    video = Video.find_by(id: params[:video_id])
    customer = Customer.find_by(id: params[:customer_id])
    date = DateTime.now + 1.week
    rental = Rental.new(due_date: date, customer_id: customer.id, video_id: video.id)

    if rental.save 
      render json: rental.as_json(except: [:created_at, :updated_at]), status: :created
      return 
    else
      render json: {
        "errors": rental.errors.messages
        }, status: :bad_request
      return 
    end 

  end 
end
