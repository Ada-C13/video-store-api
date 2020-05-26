class CustomersController < ApplicationController
  def index
    customers = Customer.all

    render json: { ok: 'success' }, status: :ok
  end
end
