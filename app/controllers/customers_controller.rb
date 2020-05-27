class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json(only: [:id, :name, :address, :city, :state, :postal_code, :phone, :registered_at, :videos_checked_out_count]),
       status: :ok
  end
end
