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
  
  describe 'show' do
    it 'returns a hash with correct fields for an existing customer' do
      customer = customers(:junito)
      
      get customer_path(customer.id)
      
      body = JSON.parse(response.body)
      
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal CUSTOMER_FIELDS
    end
    
    it 'returns a 404 response with JSON for a non-existant customer' do
      get customer_path('bad_id')
      
      must_respond_with :not_found
      
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Hash
      expect(body['ok']).must_equal false
      expect(body['message']).must_equal 'Not found'
    end
  end
  
  
end
