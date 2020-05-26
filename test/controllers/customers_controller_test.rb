require "test_helper"

describe CustomersController do
  CUSTOMER_FIELDS = ['id', 'name', 'postal_code', 'phone', 'videos_checked_out_count', 'registered_at'].sort
  
  describe 'index' do
    
    it 'gets the index path' do
      get customers_path
      
      must_respond_with :success 
      
      expect(response.header['Content-Type']).must_include 'json'
      #TODO: check_response(expected_type: Array)
    end
    
    it 'returns correct fields for the list of customers' do
      get customers_path
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      
      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.keys.sort).must_equal CUSTOMER_FIELDS
      end
      
    end
    
    it 'returns an empty array if there are no customers in the database' do
      Customer.destroy_all 
      get customers_path
      
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0
      
    end
    
  end
  
  
  
  
end
