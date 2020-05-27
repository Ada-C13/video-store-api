class CustomersController < ApplicationController
  def index
    @customers = Customer.all

    render json: {ok: 'YEEEEEES'}, status: :ok
  end
end
