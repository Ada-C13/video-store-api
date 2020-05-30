class CustomersController < ApplicationController
  def index 
    customers = Customer.order(:name).as_json(only: [:id, :name, :postal_code, :phone, :videos_checked_out_count, :registered_at])
    render json: customers, status: :ok
  end
end