require "test_helper"

describe Rental do
  describe 'relations' do 
    
    describe 'customer' do 

      it "can set up customer through customer" do 
        customer = customers(:kiayada)
        rental = Rental.new
        
        rental.customer = customer
        expect(rental.customer_id).must_equal customer.id
      end 

      it "can set up customer via customer_id" do 

        customer = customers(:kiayada) 
        rental = Rental.new
        

        rental.customer_id = customer.id
        expect(rental.customer).must_equal customer
        expect(rental.customer.name).must_equal customer.name
      end 
    end 
  end 
end
