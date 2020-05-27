require 'pry'
class RentalsController < ApplicationController
  def index
    rentals = Rental.all
    render json: rentals.as_json(),
           status: :ok
  end

  def check_out
    customer = Customer.find_by(id: params[:customer_id])
    video = Video.find_by(id: params[:video_id])

    if video.nil? || customer.nil?
      render json: {
        ok: false,
        errors: "Unable to create rental",
      }, status: :not_found
      return
    end

    if !video.available
      render json: {
        ok: false,
        errors: "Unable to create rental",
      }, status: :bad_request
      return
    end

    rental = Rental.new(customer_id: customer.id, video_id: video.id)
    rental.check_out_date = Date.today
    rental.due_date = Date.today + 7

    if rental.save
      
      video.decrease_inventory
      customer.add_to_checked_out
      render json: {customer_id: rental.customer_id,
                  video_id: rental.video_id, 
                  due_date: rental.due_date,
                  videos_checked_out_count: customer.videos_checked_out_count,
                  available_inventory: video.available_inventory}, status: :ok
      return
    else
      render json: {
        ok: false,
        errors: rental.errors.messages,
      }, status: :bad_request
      return
    end
  end

  def check_in
    rental = Rental.find_by(customer_id: params[:customer_id],video_id: params[:video_id], check_in_date: nil)

    if rental.nil?
      render json: {
        ok: false,
        errors: "Rental not found",
      }, status: :not_found
      return
    end

    video = Video.find_by(id: params[:video_id])
    customer = Customer.find_by(id: params[:customer_id])

    rental.check_in_date = Date.today
    
    if rental.save
      video.increase_inventory
      customer.remove_checked_out
      render json: {customer_id: rental.customer_id,
                    video_id: rental.video_id, videos_checked_out_count: customer.videos_checked_out_count,
                    available_inventory: video.available_inventory}, status: :ok
      return
    else
      render json: {
        ok: false,
        errors: rental.errors.messages,
      }, status: :bad_request
      return
    end
  end

  private

  def check_in_params
    return params.require(:rental).permit(:customer_id, :video_id)
  end
end
