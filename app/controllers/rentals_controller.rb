class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :update, :destroy]

  # POST /rentals/check-in
  def check_in 
    rental = Rental.find_by(customer_id: rental_params[:customer_id], video_id: rental_params[:video_id])

    if rental
      rental.returned_on = Time.now
      rental.video.available_inventory += 1
      rental.save

      response = { 
        customer_id: rental.customer_id,
        video_id: rental.video_id,
        videos_checked_out_count: rental.customer.videos_checked_out_count,
        available_inventory: rental.video.available_inventory,
      }
      render json: response, status: :ok
    else
      render json: { error: rental }, status: :unprocessable_entity
    end

  end

  # POST /rentals/check-out
  # create a new Rental record 
  # params: customer_id, video_id
  # on success: increase customer's videos checked out +1 (done via counter cache)
  # decrease video available inventory by 1 
  def check_out
    @rental = Rental.new(rental_params)

    if @rental.save
      @rental.video.available_inventory -= 1
      response = { 
        customer_id: @rental.customer_id,
        video_id: @rental.video_id,
        due_date: get_due_date(@rental),
        videos_checked_out_count: @rental.customer.videos_checked_out_count,
        available_inventory: @rental.video.available_inventory 
      }
      render json: response, status: :ok
    else
      render json: @rental.errors, status: :unprocessable_entity
    end
  end

  def get_due_date(rental)
    return rental.created_at + 7.days
  end


  # # GET /rentals
  # def index
  #   @rentals = Rental.all

  #   render json: @rentals
  # end

  # # GET /rentals/1
  # def show
  #   render json: @rental
  # end

  # # POST /rentals
  # def create
  #   @rental = Rental.new(rental_params)

  #   if @rental.save
  #     render json: @rental, status: :created, location: @rental
  #   else
  #     render json: @rental.errors, status: :unprocessable_entity
  #   end
  # end

  # # PATCH/PUT /rentals/1
  # def update
  #   if @rental.update(rental_params)
  #     render json: @rental
  #   else
  #     render json: @rental.errors, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /rentals/1
  # def destroy
  #   @rental.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rental_params
      params.permit(:customer_id, :video_id)
    end
end
