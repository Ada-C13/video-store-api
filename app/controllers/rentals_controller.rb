class RentalsController < ApplicationController

  def checkin
    video_id = params[:video_id]
    customer_id = params[:customer_id]
    video = Video.find_by(id: video_id)
    customer = Customer.find_by(id:customer_id)

    if video != nil && customer != nil
      @rental = Rental.new(customer_id: customer_id, video_id: video_id)
      
      Rental.checkout(customer_id: customer_id, video_id: video_id, rental: @rental)
      @rental.save!
      render json: @rental.as_json, status: :created
      return
    else
      render json: {ok: false, errors: @rental.errors.messages}, status: :bad_request
      return
    end
  
  end


  def checkout
  end

  private
  def rental_params
    params.require(:rental).permit(:video_id, :customer_id)
  end
end
