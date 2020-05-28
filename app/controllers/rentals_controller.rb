class RentalsController < ApplicationController
  def check_out
    video = Video.find_by(id: params[:video_id])
    customer = Customer.find_by(id: params[:customer_id])
    rental = Rental.new(customer: customer, video: video, due_date: (Date.today + 7))

    if !video.nil? && video.available_inventory <= 0 
      render json: {
        errors: ['Not Found']
      }, status: :not_found
      return
    elsif rental.save 
      video.available_inventory -= 1
      video.save
      customer.videos_checked_out_count += 1
      customer.save
      
      render json: { customer_id: rental.customer_id,
        video_id: rental.video_id,
        due_date: rental.due_date,
        videos_checked_out_count: customer.videos_checked_out_count,
        available_inventory: video.available_inventory }       
    else
      render json: {
        errors: ['Not Found']
      }, status: :not_found

      return
    end
  end

  def check_in
    rental =  Rental.find_by(customer_id: params[:customer_id], video_id: params[:video_id])

    if rental.nil?
      render json: {
        ok: false,
        errors: "This rental does not exist",
      },status: :not_found
    elsif rental 
      rental.customer.videos_checked_out_count -= 1
      rental.video.available_inventory += 1
      rental.returned = true
      rental.save
      
      render json: { customer_id: rental.customer_id,
        video_id: rental.video_id,
        due_date: rental.due_date,
        videos_checked_out_count: customer.videos_checked_out_count,
        available_inventory: video.available_inventory }       
    end
  end

end