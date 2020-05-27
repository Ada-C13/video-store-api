class RentalsController < ApplicationController

  def check_out
    customer = Customer.find_by(id: params[:customer_id])
    video = Video.find_by(id: params[:video_id])

    if video
      video = video.available
    end


    if video && customer
      rental = Rental.new(customer_id: customer.id, video_id: video.id)
      rental.check_out_date = Date.today
      rental.due_date = Date.today + 7

      if rental.save
        video.decrease_inventory
        customer.add_to_checked_out
        render json: rental.as_json(only: [:id, :due_date, :customer_id]), status: :ok
        return
      else
        render json: {
          ok: false,
          errors: rental.errors.messages,
        }, status: :bad_request
        return
      end
    else
      render json: {
        ok: false,
        errors: "Unable to create rental",
      }, status: :bad_request
      return
    end
  end
end
