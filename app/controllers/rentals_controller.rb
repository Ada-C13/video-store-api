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
			puts "BEFORE CUSTOMER CHECKOUT: #{customer.videos_checked_out_count}"
			customer.videos_checked_out_count += 1
			puts "AFTER CUSTOMER CHECKOUT: #{customer.videos_checked_out_count}"
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
			puts "BEFORE VIDEO CHECKOUT: #{video.available_inventory}"
			video.available_inventory -= 1
			puts "AFTER VIDEO CHECKOUT: #{video.available_inventory}"
			video.save
		end

		rental = Rental.new(rental_params)
		rental.due_date = Date.today + 7

		if rental.save
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

		if customer.videos_checked_out_count < 1
			render json: {
				ok: false,
				errors: 'You cannot check-in a video.'
			}, status: :bad_request
			return
		end

		rental = Rental.where(customer_id: rental_params[:customer_id], video_id: rental_params[:video_id])

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
			puts "HERE?"
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
