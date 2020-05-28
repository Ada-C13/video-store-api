class RentalsController < ApplicationController


    def checkin
        rental = Rental.find_by(customer_id: rental_params[:customer_id])
        puts "rental #{rental}"
        puts "customer #{rental_params[:customer_id]}"
        puts "video #{rental_params[:video_id]}"
        puts Customer.find_by(id: 23)
        Rental.all.each{ |rental| p [rental.customer_id, rental.video_id]}

        
        if rental
            rental.checked_in = Date.today
        else 
           puts "hiiiiiiiiiiiiii" 
        render json: { 
            errors: "rental does not exist!"
        }, status: :not_found
           return
        end


        if rental.save
            rental.decrease_count
            render json: { 
                customer_id: rental.customer_id, 
                video_id: rental.video_id,
                due_date: rental.due_date,
                videos_checked_out_count: rental.customer.videos_checked_out_count, 
                available_inventory: rental.video.available_inventory
            },status: :ok
            return
                else 
            render json:  {
                errors: ['Not Found'] 
            }, status: :not_found
            return
        end
    end

    def checkout
        rental = Rental.new(rental_params)
        rental.checked_out = Date.today
        rental.due_date = rental.checked_out + 7.days
        if rental.save
            rental.add_to_count

            render json: { 
                customer_id: rental.customer_id, 
                video_id: rental.video_id,
                due_date: rental.due_date,
                videos_checked_out_count: rental.customer.videos_checked_out_count, 
                available_inventory: rental.video.available_inventory
            },status: :ok
            #(only: [:customer_id, :video_id, :due_date, :rental.customers.videos_checked_out_count, :available_inventory]), 
            return 
        else 
            
            render json: {
                errors: ['Not Found'] 
            }, status: :not_found
            return
        end
    end



    private
    def rental_params
        return params.permit(:video_id, :customer_id, :due_date, :checked_out, :checked_in)
      end
end
