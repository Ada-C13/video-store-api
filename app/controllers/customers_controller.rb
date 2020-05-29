class CustomersController < ApplicationController
  def index
    customers = Customer.order(:name)

    render json: customers.as_json(except: [:created_at, :updated_at, :address, :city, :state]), status: :ok
  end
end
