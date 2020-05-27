require 'date'

class RentalsController < ApplicationController

  def index 
    rental = Rental.all
    render json: rental.as_json(except: [:id, :updated_at, :created_at]), status: :ok
  end 

  def check_out 
    video = Video.find_by(id: params[:video_id] )
    customer = Customer.find_by(id: params[:customer_id])
    date = DateTime.now + 1.week

    if customer.nil? || video.nil? 
      render json: {
        errors: [
            "Not Found"
          ]
        }, status: :not_found
      return
    end 

   rental = Rental.new(due_date: date, customer_id: customer.id, video_id: video.id)

    if Rental.inventory_check_out(rental) && rental.save 
      
      video.reload
      customer.reload

      render json: {
        customer_id: rental.customer_id,
        video_id: rental.video_id,
        due_date: rental.due_date,
        videos_checked_out_count: customer.videos_checked_out_count,
        available_inventory: video.available_inventory
      }, status: :ok
      
      return 
    else
      render json: {
        "errors": [
            "No Inventory Available"
          ]
        }, status: :bad_request
      return 
    end 
  end 

  def check_in 
    video = Video.find_by(id: params[:video_id])
    customer = Customer.find_by(id: params[:customer_id])

    if customer.nil? || video.nil? 
      render json: {
        errors: ["Not Found"]
        }, status: :not_found
      return
    end 

    rental = Rental.find_by(video_id: video.id, customer_id: customer.id)

    if rental.nil?
      render json: {
        errors: ["Not Found"]
        }, status: :not_found
      return
    end 

    if Rental.inventory_check_in(rental) && rental.save 
      video.reload
      customer.reload

      render json: {
        customer_id: rental.customer_id,
        video_id: rental.video_id,
        videos_checked_out_count: customer.videos_checked_out_count,
        available_inventory: video.available_inventory
      }, status: :ok
      
      return 
    else
      render json: {
        errors: rental.errors.messages
        }, status: :bad_request
      return 
    end 
  end 
end
