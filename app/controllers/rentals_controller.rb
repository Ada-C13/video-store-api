class RentalsController < ApplicationController
  def check_out
    video = Video.find_by(id: params[:rental][:video_id])
    customer = Customer.find_by(id: params[:rental][:customer_id])
    rental = Rental.new(customer: customer, video: video, due_date: (Date.today + 7))

    if !video.nil? && video.available_inventory <= 0 
      render json: {
        ok: false,
        "errors": ["Video does not have any available inventory"],
        status: :not_found
      }
    elsif rental.save 
      customer.videos_checked_out_count += 1
      customer.save
      video.available_inventory -= 1
      video.save
      render json: rental, status: :ok
    else
      render json: {
        ok: false,
        errors: [rental.errors.messages],
        status: :bad_request
      }
      return
    end

  end

end


# elsif video.nil? && customer.nil?
#   render json: {
#     ok: false,
#     "errors": ["Video and customer not valid"],
#     status: :not_found
#   }
# elsif video.nil?
#   render json: {
#     ok: false,
#     "errors": ["Video not valid"],
#     status: :not_found
#   }
# elsif customer.nil?
#   render json: {
#     ok: false,
#     "errors": ["Customer not valid"],
#     status: :not_found
#   }