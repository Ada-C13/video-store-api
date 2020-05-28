class CustomersController < ApplicationController
 KEYS =  [:id, :name, :registered_at, :postal_code, :phone, :videos_checked_out_count]

    def index 
      customers = Customer.order(:name).all.as_json(only: KEYS.sort)  
      render json: customers, status: :ok
    end

    private
  
    def customer_params
      return params.require(:customer).permit(:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone, :videos_checked_out_count)
    end

 end
