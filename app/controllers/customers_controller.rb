class CustomersController < ApplicationController
  def index
    customers = Customer.order(:name).as_json(only: [:id, :name, :postal_code, :phone, :registered_at, :videos_checked_out_count])
    render json: customers, status: :ok
  end

  def show
    customer = Customer.find_by(id: params[:id])

    if customer
      render json: customer.as_json(only: [:id, :name, :address, :city, :state, :postal_code, :phone, :registered_at])
      return
    else
      render json: { ok: false, errors: ["Not Found"] }, status: :not_found
      return
    end
  end
end
