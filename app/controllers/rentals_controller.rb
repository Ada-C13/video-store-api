class RentalsController < ApplicationController

  def check_out
    video = Video.find_by(id: params[:video_id])
    customer = Customer.find_by(id: params[:customer_id])
    # rental = Rental.new(customer_id: params[:customer_id], video_id: rental_params[:video_id], due_date: (Date.today + 7))
    rental = Rental.new(rental_params)
    rental.due_date = Date.today + 7.days

    if video.nil? || customer.nil? || video.available_inventory < 1
      render json: {
        errors: ['Not Found'],
      }, status: :not_found
      return
    end

    if rental.save
      rental.video.decrease_available_inventory
      rental.customer.increase_checked_out_count

      render json: {
        customer_id: rental.customer_id,
        video_id: rental.video_id,
        due_date: rental.due_date,
        videos_checked_out_count: rental.customer.videos_checked_out_count,
        available_inventory: rental.video.available_inventory
      },
        status: :ok
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
    video = Video.find_by(id: params[:video_id])
    customer = Customer.find_by(id: params[:customer_id])
    rental = Rental.find_by(customer: customer, video: video)

    if rental.nil?
      render json: {
          errors: ['Not Found']
        }, status: :not_found
        return
    else
      video.increase_available_inventory
      customer.decrease_checked_out_count

      render json: {
        customer_id: rental.customer_id,
        customer_id: rental.customer_id,
        video_id: rental.video_id,
        videos_checked_out_count: rental.customer.videos_checked_out_count,
        available_inventory: rental.video.available_inventory
    }, 
      status: :ok
      return
    end
  end

  private

  def rental_params
    return params.permit(:customer_id, :videos_id)
  end
end
