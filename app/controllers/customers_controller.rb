class CustomersController < ApplicationController
  def index
    customers = Customer.all.order(:name)

    render json: customers.as_json(except: [:created_at, :updated_at]), status: :ok
  end
end
