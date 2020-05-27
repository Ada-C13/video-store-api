class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json(only: [:id, :name, :postal_code, :phone, :registered_at, :videos_checked_out_count]),
           status: :ok
  end

  def show
    customer = Customer.find_by(id: params[:id])

    if customer.nil?
      render json: {
        # ok: false,
        errors: ["Not Found"],
      }, status: :not_found

      return
    end

    render json: customer.as_json(only: [:id, :name, :address, :city, :state, :postal_code, :phone, :registered_at, :videos_checked_out_count]),
      status: :ok
  end
end
