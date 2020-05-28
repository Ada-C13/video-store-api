class CustomersController < ApplicationController
  def index
    @customers = Customer.order(:name)
    
    render json: @customers.to_json(
      :only => [:id, :name, :registered_at, :postal_code, :phone], :methods => [:videos_checked_out_count]), status: :ok
  
  end
end


