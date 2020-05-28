class RentalsController < ApplicationController
  before_action :find_video_and_customer, only: [:check_out, :check_in]

  def check_out 
    
    if @video.nil? || @customer.nil? 
      render json: {
        errors: ['Not Found'],
      }, status: :not_found 

      return 
    end 

    if @video.available_inventory <= 0

      render json: {
        ok: false,
        errors: "Not Available"
      }, status: :bad_request

      return
    end 


    rental = Rental.new(rental_params)
    rental.update_check_out_dates # check_out and due_date


    if rental.save 
      @customer.increment_checked_out_count # for customer
      @video.decrement_available_inventory # for video

      render json: {
        customer_id: rental.customer_id,
        video_id: rental.video_id,
        due_date: rental.due_date,
        videos_checked_out_count: @customer.videos_checked_out_count,
        available_inventory: @video.available_inventory
      },
      status: :ok

      return

    end
  end

  def check_in 
    if @video.nil? || @customer.nil? 
      render json: {
        errors: ['Not Found'],
      }, status: :not_found 

      return 
    end 

    rental = Rental.find_by(rental_params)
    rental.update_check_in_date 


    if rental.save 

      @customer.decrement_checked_out_count # for customer
      @video.increment_available_inventory # for video

      render json: {
        customer_id: rental.customer_id,
        video_id: rental.video_id,
        videos_checked_out_count: @customer.videos_checked_out_count,
        available_inventory: @video.available_inventory
      },
      status: :ok

      return

    end

  end 

  private

  def rental_params
    params.permit(:customer_id, :video_id)
  end

  def find_video_and_customer 
    @video = Video.find_by(id: params[:video_id])
    @customer = Customer.find_by(id: params[:customer_id])
  end
end
