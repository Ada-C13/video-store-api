class CustomersController < ApplicationController
    
    REQUIRED_CUSTOMER_FIELDS = [:id, :name, :registered_at, :postal_code, :phone, :videos_checked_out_count]
    
    def index
        customers = Customer.all.as_json(only: REQUIRED_CUSTOMER_FIELDS)
        render json: customers, status: :ok
    end
end
