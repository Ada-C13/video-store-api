class CustomersController < ApplicationController
  
  def index
    customers = Customer.all.order(:name)
    
    # render some json stuff
    render json: customers.as_json(only: [:id, :name, :postal_code, :phone, :videos_checked_out_count, :registered_at]),
    status: :ok
  end
  
  def show
    customer = Customer.find_by(id: params[:id])
    
    if customer.nil?
      render json: {
        ok: false,
        message: 'Not found'
        }, status: :not_found
        
        return  
      end
      
      render json: customer.as_json(only: [:id, :name, :postal_code, :phone, :videos_checked_out_count, :registered_at])
      
      
    end
    
  end