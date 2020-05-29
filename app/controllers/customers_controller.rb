class CustomersController < ApplicationController

  def index 
    customers = Customer.order(:name).as_json(only: [:id, :name, :postal_code, :phone, :registered_at, :videos_checked_out_count])
    render json: customers,  status: :ok                                
  end
 
end
