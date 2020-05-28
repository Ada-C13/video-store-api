require 'date'

class RentalsController < ApplicationController
  
  #decrease available_inventory
  #increase videos_checked_out_count
  #POST
  def check_out
    #calling required params immediately
    #in Postman, test that this gets triggered by mispelling "rentals" to "rentils", will return a 400
    # rental_params()

    #accessing customer_id and video_id
    customer_id = rental_params[:customer_id]
    video_id = rental_params[:video_id]
    # puts customer_id
    # puts video_id
    
    #quering DB to find customer and video object
    customer = Customer.find_by(id: customer_id)
    video = Video.find_by(id: video_id) #another version: video = Video.find(video_id)
    
    # puts customer.name
    # puts video.title

    #check if customer_id and video_id exist
    if customer.nil? || video.nil?
      #head :not_found #404
      # response with error message per requirement
      render json: {
        "errors": [
          "Not Found"
        ]
      }, status: :not_found
      
      return
    end

    #check if available_inventory is less than 1
    #Req: The API should return back detailed errors and a status 400: Bad Request if the video does not have any available inventory before check out
    if video.available_inventory < 1
      # response with error message per requirement
      render json: {
        "errors": [
          "No available inventory"
        ]
      }, status: :bad_request

      return
    end

    # increase the customer's videos_checked_out_count by one (customers)
    customer.videos_checked_out_count += 1
    # decrease the video's available_inventory by one (videos)
    video.available_inventory -= 1
    # create a due date. The rental's due date is the seven days from the current date.
    #https://stackoverflow.com/questions/8196434/rails-datetime-now-without-time
    due_date = (DateTime.current.to_date) + 7 
    #puts due_date

    #create rental object
    rental = Rental.new
    rental.customer_id = customer_id
    rental.video_id = video_id
    rental.check_out = DateTime.current.to_date
    rental.due_date = due_date

    #if rental is able to save, then also save customer and video
    #if rental does not save, then customer and video don't save
    #helps DB stay in sync
    if rental.save #save to db
      customer.save #save customer object with video checked out count back to db
      video.save #save video available inventory back to db
    end

    #manually create the json to meet requirement
    render json: {"customer_id": customer_id,
      "video_id": video_id,
      "due_date": due_date,
      "videos_checked_out_count": customer.videos_checked_out_count,
      "available_inventory": video.available_inventory}, 
      status: :ok

  end #check_out method
  
  #*********************************************************************

  def check_in
    # rental_params
    #accessing customer_id and video_id
    customer_id = rental_params[:customer_id]
    video_id = rental_params[:video_id]

    #quering DB to find customer and video object
    customer = Customer.find_by(id: customer_id)
    video = Video.find_by(id: video_id)

    #check if customer_id and video_id exist
    if customer.nil? || video.nil?
      #head :not_found #404
      # response with error message per requirement
      render json: {
        "errors": [
          "Not Found"
        ]
      }, status: :not_found
      return
    end

    # decrease the customer's videos_checked_out_count by one (customers)
    customer.videos_checked_out_count -= 1
    # increase the video's available_inventory by one (videos)
    video.available_inventory += 1

    #find first rental object
    #limit 1 bc scenario: i check out 20 copies of jurassic park, but when i check in, i will return just 1
    #return the one is due soonest
    rentals = Rental.where(check_in: nil, customer_id: customer_id, video_id: video_id).order(due_date: :asc).limit(1)
    #check if rental exists
    if rentals.nil? || rentals.length == 0
      #head :not_found #404
      render json: {
        "errors": {
          "rental": [
            "Not found"
          ]
        }
      }, status: :not_found
      
      return
    end
    
    #populate the check in date
    rental = rentals[0]
    #when i check in a video, i use today's date
    rental.check_in = DateTime.current.to_date

    #need to save updates made to rental in db
    if rental.save #save to db
      customer.save #save customer object with video checked out count back to db
      video.save #save video available inventory back to db
    end

    #manually create the json to meet requirement
    render json: {"customer_id": customer_id,
      "video_id": video_id,
      "videos_checked_out_count": customer.videos_checked_out_count,
      "available_inventory": video.available_inventory}, 
      status: :ok

  end #check in method

  
  private

  def rental_params
    return params.permit(:customer_id, :video_id)
  end

end #class

