class RentalsController < ApplicationController
  def index
    rentals = Rental.all
    render json: rentals.as_json(), status: :ok
  end

def check_out
  customer = Customer.find_by(id: params[:customer_id])
  video = Video.find_by(id: params[:videos_id])
  rental = Rental.new(customer_id: params[:customer_id], videos_id: params[:videos_id], check_out_date: Date.today, due_date: (Date.today + 7))
# require "pry"
# binding.pry
  if video.nil? || customer.nil? || video.available_inventory < 1
    render json: {
      errors: rental.errors.messages
    }, status: :not_found
    return
  end
  if rental.save
    # require "pry"
    # binding.pry
    video.decrease_inventory
    customer.add_videos_to_checked_out
    render json: {
      customer_id: rental.customer_id,
      videos_id: rental.videos_id,
      due_date: rental.due_date},
      status: :created
      return
  end
end



  def check_in
    rental = Rental.find_by(customer_id: params[:customer_id], videos_id: params[:videos_id], check_in_date: nil)

    if rental.nil?
      render json: {
        errors: ["Not Found"]
      }, status: :not_found
      return
    end
    
    customer = Customer.find_by(id: params[:customer_id])
    video = Video.find_by(id: params[:videos_id])
    rental.check_in_date = Date.today

    if rental.save
      video.increase_inventory
      customer.remove_videos_from_checked_out
      render json: {customer_id: rental.customer_id, 
                    videos_id: rental.videos_id, videos_checked_out_count: customer.videos_checked_out_count,
                    available_inventory: video.available_inventory}, 
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

  private

  def rental_params
    return params.permit(:customer_id, :videos_id)
  end
end