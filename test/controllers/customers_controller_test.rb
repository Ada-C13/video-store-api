require "test_helper"

describe CustomersController do
  CUSTOMER_FIELDS = ["id", "name", "registered_at", "postal_code", "phone", "videos_checked_out_count"].sort
  
  describe 'index' do
    it 'responds with JSON and success' do
      get customers_path
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it 'will return all the proper fields for a list of customers' do
      get customers_path
      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Array

      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.keys.sort).must_equal CUSTOMER_FIELDS
      end
    end

    it 'returns an empty array if no customers exist' do
      Customer.destroy_all
      get customers_path
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0
    end
  end

  describe 'show' do
    before do 
      @customer = customers(:customer1)
    end
    it 'responds with JSON and success' do
      get customer_path(@customer.id)
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end

    it 'will return a hash with all proper fields for an existing customer' do
      get customer_path(@customer.id)
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal CUSTOMER_FIELDS
    end

    it 'will return a 404 request with json for a non-existant customer' do
      get customer_path(-1)

      must_respond_with :not_found
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body['success']).must_equal false
      expect(body['message']).must_equal 'Not found'
    end
  end

end
