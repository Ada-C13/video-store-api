require "test_helper"

describe CustomersController do
  # CUSTOMER_FIELDS = ['id', 'name', 'postal_code', 'phone', 'videos_checked_out_count', 'registered_at'].sort
  
  describe 'index' do
    
    it 'gets the index path' do
      get customers_path
      
      must_respond_with :success 
      
      expect(response.header['Content-Type']).must_include 'json'
    end
    
    # it 'returns correct fields for the list of customers' do
    
    # end
    
    # it 'returns an empty array if there are no customers in the database' do
    
    # end
    
  end
  
  # describe 'show' do
  #   it 'returns a hash with correct fields for an existing customer' do
  
  #   end
  
  #   it 'returns a 404 response with JSON for a non-existant customer' do
  
  #   end
  # end
  
  
end
