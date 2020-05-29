class RentalsController < ApplicationController
  def index
    rentals = Rental.all
    render json: rentals.as_json(),
           status: :ok
  end

  def check_out
    rental = Rental.new(rentals_params.merge({ checked_out_date: DateTime.now, due_date: DateTime.now + 7.days }))
    video = Video.find_by(id: rentals_params[:video_id])
    customer = Customer.find_by(id: rentals_params[:customer_id])

    if customer.nil?
      render json: { errors: ["Not Found"] }, status: :not_found
      return
    end

    if video.nil?
      render json: { errors: ["Not Found"] }, status: :not_found
      return
    end

    if video.available_inventory > 0
      rental.save

      video.decrease_inventory
      customer.add_checked_out
    end

    render json: {
             customer_id: customer.id,
             video_id: video.id,
             due_date: rental.due_date,
             videos_checked_out_count: customer.videos_checked_out_count,
             available_inventory: video.available_inventory,
           }
  end

  def check_in
    rental = Rental.find_by(customer_id: params[:customer_id], video_id: params[:video_id], checked_in_date: nil)
    video = Video.find_by(id: params[:video_id])
    customer = Customer.find_by(id: params[:customer_id])

    if rental.nil?
      render json: { errors: ["Not Found"] }, status: :not_found
      return
    end

    rental.checked_in_date = DateTime.now

    if rental.save
      video.increase_inventory
      customer.remove_checked_out
      render json: { customer_id: rental.customer_id,
                     video_id: rental.video_id, videos_checked_out_count: customer.videos_checked_out_count,
                     available_inventory: video.available_inventory }, status: :ok
      return
    else
      render json: { ok: false, errors: rental.errors.messages }, status: :bad_request
      return
    end
  end

  def rentals_params
    return params.permit(:customer_id, :video_id)
  end
end
