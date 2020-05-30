class RentalsController < ApplicationController

  def check_in
    customer = Customer.find_by(id: rental_params[:customer_id])
    video = Video.find_by(id: rental_params[:video_id])
    if customer.nil? || video.nil?
      render json: { ok: false, errors: "Customer or video not found" },
        status: :not_found
      return
    end
    rental = Rental.find_by(customer_id: params[:customer_id])
    rental.save
    rental.check_in
    render json: rental.as_json(only:
        [:customer_id, :video_id, :videos_checked_out_count, :available_inventory]
      ), status: :ok 
  end
  

  def check_out
    rental = Rental.new(rental_params)
    customer = Customer.find_by(id: rental_params[:customer_id])
    video = Video.find_by(id: rental_params[:video_id])
    if customer.nil? || video.nil?
      render json: { ok: false, errors: rental.errors.messages },
       status: :not_found
       return
    end
    if video.available_inventory <= 0
      render json: { ok: false, errors: "Video not available." }, status: :bad_request
      return
    end
    rental.check_out
    rental.save
    render json: rental.as_json(only: 
      [:customer_id, :video_id, :due_date, :videos_checked_out_count, :available_inventory
      ]), status: :created
  end


  private
  def rental_params
    params.permit(:customer_id, :video_id)
  end
end
