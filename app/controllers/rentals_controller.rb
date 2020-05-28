class RentalsController < ApplicationController
  
  #decrease available_inventory
  #increase videos_checked_out_count
  def check_out
    @video = Video.find_by(id: params[:id])
    @customer = Customer.find_by(id: params[:id])
    
    if video.nil? && customer.nil?
      rental = Rental.find_by(customer_id: @customer.id, video_id: @video.id)
      if (rental.nil?) && (@video.video_id.available_inventory > 0) #this availability has to be the same as the video_id
        rental_params = {customer_id: @customer.id, video_id: @video.id}
        new_rental = Rental.new(rental_params)
        #videos_checked_out_count needs to increment
      end
    else #video and customer are nil, show error
      render json: {
        ok: false,
        message: 'Not found',
      }, status: :not_found
    end

  end #check_out method
  
  
  def check_in
    #increase available_inventory

    #decrease videos_checked_out_count

  end

  

  private

  # def rental_params
  #   return params.require(:rental).permit(:customer_id, :video_id)
  # end

end #class

