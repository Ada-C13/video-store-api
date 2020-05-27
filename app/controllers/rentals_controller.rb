class RentalsController < ApplicationController

	def check_out
		customer = Customer.find_by(id: rental_params[:customer_id])

		if customer.nil?
			render json: {
				errors: ['Not Found']
			}, status: :not_found
			return
		end

		video = Video.find_by(id: rental_params[:video_id])
		
		if video.nil?
			render json: {
				errors: ['Not Found']
			}, status: :not_found
			return
		elsif video.available_inventory < 1
			render json: {
				errors: ['Not Found']
			}, status: :bad_request
			return
		end

		rental = Rental.new(rental_params)
		rental.due_date = Date.today + 7

		if rental.save
			customer.videos_checked_out_count += 1
			customer.save
			video.available_inventory -= 1
			video.save

			rental_info = {
				customer_id: rental.customer_id,
				video_id: rental.video_id,
				due_date: rental.due_date,
				available_inventory: video.available_inventory,
				videos_checked_out_count: customer.videos_checked_out_count
			}
			
			render json: rental_info.as_json, status: :ok
			return
		else
			render json: {
				errors: ['Not Found']
			}, status: :bad_request
			return
		end
	end

	def check_in
		customer = Customer.find_by(id: rental_params[:customer_id])

		if customer.nil?
			render json: {
				errors: ['Not Found']
			}, status: :not_found
			return
		end

		video = Video.find_by(id: rental_params[:video_id])

		if video.nil?
			render json: {
				errors: ['Not Found']
			}, status: :not_found
			return
		end

		rental = Rental.find_by(customer_id: rental_params[:customer_id].to_i, video_id: rental_params[:video_id].to_i)

		if rental
			customer.videos_checked_out_count -= 1
			customer.save
			video.available_inventory += 1
			video.save

			rental_info = {
				customer_id: customer.id,
				video_id: video.id,
				available_inventory: video.available_inventory,
				videos_checked_out_count: customer.videos_checked_out_count
			}

			render json: rental_info, status: :ok
			return
		else
			render json: {
				errors: ['Not Found']
			}, status: :bad_request
			return
		end
	
	end

	private

	def rental_params
		return params.permit(:customer_id, :video_id)
	end

end
