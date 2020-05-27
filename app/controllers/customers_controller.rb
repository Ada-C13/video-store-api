class CustomersController < ApplicationController

  def index
    customers = Customer.all.as_json(only: [:id, :name, :address, :city, :state, :postal_code, :phone, :registered_at])
    render json: customers,  status: :ok
                                   
  end


  def create
    customer = Customer.new(customer_params)

    if customer.save
      render json: customer.as_json(only: [:id]), status: :created
      return
    else
      render json: {
          ok: false,
          errors: video.errors.messages
        }, status: :bad_request
      return
    end
  end


  def show
    customer = Customer.find_by(id: params[:id])

    if custormer
      render json: customer.as_json(only: [:id, :name, :address, :city, :state, :postal_code, :phone, :registered_at])
      return
    else
      render json: { ok: false, errors: ["Not Found"] }, status: :not_found
      return
    end
  end



  private

  def customer_params
    return params.require(:customer).permit(:name, :address, :city, :state, :postal_code, :phone, :registered_at)
  end

end
