class RentalsController < ApplicationController

  def checkout
    video_id = params[:video_id]
    customer_id = params[:customer_id]
    video = Video.find_by(id: video_id)
    customer = Customer.find_by(id:customer_id)

    @rental = Rental.new(customer_id: customer_id, video_id: video_id)
      
    if video != nil && customer != nil
      @checkout = @rental.checkout
     
      if @rental.save
        render json: @rental.as_json(only: [:customer_id, :video_id, :due_date, :videos_checked_out_count, :available_inventory]), status: :ok
        return
      else
        render json: {errors: ['Not Found']}, status: :not_found
        return
      end
    else
      
      render json: {errors: ['Not Found']}, status: :not_found
      return
    end
  
  end


  def checkin
    video_id = params[:video_id]
    customer_id = params[:customer_id]
    exisiting_checkout = Rental.find_by(video_id: video_id, customer_id: customer_id)

    if exisiting_checkout
      @rental = exisiting_checkout.checkin
      if @rental.save
        exisiting_checkout.destroy
        render json: @rental.as_json(only: [:customer_id, :video_id, :videos_checked_out_count, :available_inventory]), status: :ok
        return
      else
        render json: {errors: ['Not Found']}, status: :not_found
        return
      end
    else
      render json: {errors: ['Not Found']}, status: :not_found
    end
  end

  private
  def rental_params
    params.permit(:video_id, :customer_id)
  end
end
