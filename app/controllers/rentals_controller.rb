class RentalsController < ApplicationController


 

  
 
  def check_in

  end

  private

  def check_in_params
    return params.require(:rental).permit(:customer_id, :video_id)
  end
end





