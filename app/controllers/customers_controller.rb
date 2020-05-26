class CustomersController < ApplicationController
  
  def index
    customers = Customer.all.order(:name)
    
    # render some json stuff
    render json: customers.as_json(only: [:id, :name, :postal_code, :phone, :videos_checked_out_count, :registered_at]),
                                  status: :ok
  end
  
end
