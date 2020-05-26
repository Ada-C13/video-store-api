class RentalsController < ApplicationController

	def check_out
		customer = Customer.find_by(id: rental_params[:customer_id])
		if customer.nil?
			render json: {
				ok: false,
				errors: 'Customer does not exist.'
			}, status: :bad_request
			return
		else
			customer.videos_checked_out_count += 1
		end

		video = Video.find_by(id: rental_params[:video_id])
		if video.nil?
			render json: {
				ok: false,
				errors: 'Video does not exist.'
			}, status: :bad_request
			return
		elsif video.available_inventory == 0
			render json: {
				ok: false,
				errors: 'This video is out of stock.'
			}, status: :ok
			return
		else
			video.available_inventory -= 1
		end

		rental = Rental.new(rental_params)
		rental.due_date = Date.today + 7

		if rental.save
			render json: rental.as_json(only: [:customer_id, :video_id, :due_date]), status: :ok
			return
		else
			render json: {
				ok: false,
				errors: rental.errors.messages
			}, status: :bad_request
			return
		end
	end

	def check_in

	end

	private

	def rental_params
		return params.require(:rental).permit(:customer_id, :video_id)
	end

end
