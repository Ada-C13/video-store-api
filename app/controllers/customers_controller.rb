class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :videos_checked_out_count]), 
                                  status: :ok
  end

  def show
    customer = Customer.find_by(id: params[:id])

    if customer.nil?
      render json: {
        success: false,
        message: "Not found"
      }, status: :not_found

      return
    end

    render json: customer.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :videos_checked_out_count]),
                                  status: :ok
  end

  def create
    video = Video.new(pet_params)

    if video.save
      render json: video.as_json(only: [:id]), status: :created
      return
    else
      render json: {
          ok: false,
          errors: video.errors.messages
        }, status: :bad_request
      return
    end
  end

  private

  def video_params
    return params.require(:video).permit(:title, :overview, :release_date, :total_inventory, :available_inventory)
  end
end
