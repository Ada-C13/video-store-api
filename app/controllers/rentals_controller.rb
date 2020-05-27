class RentalsController < ApplicationController


    def checkin
        rental = Rental.find_by(rental_params)
        if rental
            rental.checked_in = Date.today
        else 
        render json: { 
            ok:false,
            errors: "rental does not exist!"
        }, status: :bad_request
           return
        end

        if rental.save
            rental.add_to_count
            render json: rental.as_json(only: [:id]), status: :created
            return
                else 
            render json: {
                ok:false,
                errors: rental.errors.messages
            }, status: :bad_request
            return
        end
    end

    def checkout
        rental = Rental.new(rental_params)
        rental.checked_out = Date.today
        rental.due_date = rental.checked_out + 7.days
        if rental.save
            rental.add_to_count
            render json: rental.as_json(only: [:id]), status: :created
            return
        else 
            render json: {
                ok:false,
                errors: rental.errors.messages
            }, status: :bad_request
            return
        end
    end



    private
    def rental_params
        return params.permit(:video_id, :customer_id, :due_date, :checked_out, :checked_in)
      end
end
