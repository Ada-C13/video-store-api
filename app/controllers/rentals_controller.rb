class RentalsController < ApplicationController
  # before_action :require_inventory
  # before_action :require_customer
  # before_action :require_work


  def create
    rental = Rental.new(customer_id: params[:customer_id], video_id: params[:video_id])

    if Video.find_by(id: params[:video_id]) && rental.video.available_inventory == 0
      render json: { errors: ["No available copies of the video available"] }, status: :bad_request
      return
    end

    if rental.save
      rental.customer.videos_checked_out_count += 1
      rental.customer.save
      rental.video.available_inventory -= 1
      rental.video.save
      
      render json: {
        customer_id: rental.customer_id,
        video_id: rental.video_id,
        due_date: rental.due_date,
        videos_checked_out_count: rental.customer.videos_checked_out_count,
        available_inventory: rental.video.available_inventory
      }, status: :ok

    else
      render json: {
          ok: false,
          errors: rental.errors.messages
      }, status: :not_found
    end
  end

  private

  # def require_inventory
  #   @video = Video.find_by(id: params[:video_id])
  #   if @video.available_inventory == 0
  #     render json: { errors: ["No available copies of the video available"] }, status: :bad_request
  #   end
  # end


  # def require_customer
  #   customer = Customer.find_by(id: params[:video_id])
  #   if customer.nil?
  #     render json: { errors: ["Customer Not Found"] }, status: :not_found
  #   end
  # end

  # Covered by Rails:
  # {
  #   "ok": false,
  #   "errors": {
  #       "customer": [
  #           "must exist"
  #       ],
  #       "customer_id": [
  #           "can't be blank"
  #       ]
  #   }
  # }
end
