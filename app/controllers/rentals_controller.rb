class RentalsController < ApplicationController
  def check_out
    due_date = DateTime.now + 7 
    rental = Rental.new(rental_params)
    rental.due_date = due_date

    if rental.save 

      rental.customer.videos_checked_out_count = rental.customer.videos_checked_out_count + 1 
      rental.video.available_inventory = rental.video.available_inventory - 1 

      Customer.find_by(id:rental.customer_id).update(videos_checked_out_count: rental.customer.videos_checked_out_count  )
      Video.find_by(id:rental.video_id).update(available_inventory: rental.video.available_inventory )

      checkout = {
        "customer_id": rental.customer_id,
        "video_id": rental.video_id,
        "due_date": rental.due_date,
        "videos_checked_out_count": rental.customer.videos_checked_out_count,
        "available_inventory": rental.video.available_inventory
      } 

      render json: checkout.as_json,  status: :ok

    else
      render json:{ errors: ["Not Found"]}  , status: :not_found
    end 

  end

  def check_in

    rental = Rental.where(customer_id: rental_params[:customer_id], video_id: rental_params[:video_id]).first
    customer = Customer.find_by(id:rental_params[:customer_id])
    video = Video.find_by(id:rental_params[:video_id])

    if customer.nil? || video.nil?
      render json: { errors: ["Not Found"] }, status: :not_found
    else

      customer = Customer.find_by(id:rental_params[:customer_id])
      video = Video.find_by(id:rental_params[:video_id])

      customer.videos_checked_out_count = customer.videos_checked_out_count - 1
      video.available_inventory = video.available_inventory + 1

     
      new_videos_checked_out_count = Customer.find_by(id:customer.id).videos_checked_out_count
      new_available_checked_out_count = Video.find_by(id:video.id).available_inventory

      Customer.find_by(id:customer.id).update(videos_checked_out_count: new_videos_checked_out_count - 1   )
      Video.find_by(id:video.id).update(available_inventory: new_available_checked_out_count + 1  )


     
      check_in_hash = { "customer_id": customer.id,
        "video_id": video.id,
        "videos_checked_out_count": customer.videos_checked_out_count,
        "available_inventory": video.available_inventory }

      render json: check_in_hash.as_json, status: :ok
      return
    end

  end


  private 

  def rental_params
    return params.permit(:customer_id, :video_id)
  end 
end


# video_id: rental.video_id, due_date: rental.due_date, videos_checked_out_count: rental.customer.videos_checked_out_count, available_inventory: rental.video.available_inventory