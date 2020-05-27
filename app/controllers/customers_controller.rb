class CustomersController < ApplicationController
  def index
    customers = Customer.all.order(:id)
    render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :videos_checked_out_count]), status: :ok
    return
  end

  # def current
  # end

  # def history
  # end
end
