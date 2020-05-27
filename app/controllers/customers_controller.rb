class CustomersController < ApplicationController
  CUSTOMER_FIELDS = ["id", "name", "registered_at", "address", "city", "state", "postal_code", "phone"]

  def index
    customers = Customer.all
    
    render json: customers.as_json(only: CUSTOMER_FIELDS), status: :ok
  end
end
