class RentalsController < ApplicationController

	def check_out
		customer = Customer.find_by(id: rental_params[:customer_id])
		if customer.nil?
			render json: {
				ok: false,
				errors: 'Customer does not exist.'
			}, status: :not_found
			return
		else
			customer.videos_checked_out_count += 1
			customer.save
		end

		video = Video.find_by(id: rental_params[:video_id])
		if video.nil?
			render json: {
				ok: false,
				errors: 'Video does not exist.'
			}, status: :not_found
			return
		elsif video.available_inventory == 0
			render json: {
				ok: false,
				errors: 'This video is out of stock.'
			}, status: :bad_request
			return
		else
			video.available_inventory -= 1
			video.save
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
		customer = Customer.find_by(id: rental_params[:customer_id])

		if customer.nil?
			render json: {
				ok: false,
				errors: 'Customer does not exist.'
			}, status: :not_found
			return
		end

		video = Video.find_by(id: rental_params[:video_id])

		if video.nil?
			render json: {
				ok: false,
				errors: 'Video does not exist.'
			}, status: :not_found
			return
		end

		rental = Rental.where(customer_id: rental_params[:customer_id], video_id: rental_params[:video_id])

		if rental != nil
			customer.videos_checked_out_count -= 1
			video.available_inventory += 1
			render json: rental.as_json(only: [:customer_id, :video_id]), status: :ok
			puts "REACHING?"
			return
		else
			render json: {
				ok: false,
				errors: rental.errors.messages
			}, status: :bad_request
			return
		end
	
	end

	private

	def rental_params
		return params.require(:rental).permit(:customer_id, :video_id)
	end

end
