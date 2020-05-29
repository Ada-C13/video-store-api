require "test_helper"

describe CustomersController do
  CUSTOMER_FIELDS = ["id", "name", "registered_at", "postal_code", "phone", "videos_checked_out_count"].sort
  
  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_instance_of expected_type
    return body
  end

  describe 'index' do
    it 'responds with success and must be JSON in an Array' do
      get customers_path
      check_response(expected_type: Array)
    end

    it 'will return all the proper fields for a list of customers' do
      get customers_path
      body = check_response(expected_type: Array)

      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.keys.sort).must_equal CUSTOMER_FIELDS
      end
    end

    it 'returns an empty array if no customers exist' do
      Customer.destroy_all
      get customers_path
      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end
  end

  describe 'show' do
    before do 
      @customer = customers(:customer1)
    end

    it 'responds with success and JSON in a Hash' do
      get customer_path(@customer.id)
      check_response(expected_type: Hash)
    end

    it 'will return a hash with all proper fields for an existing customer' do
      get customer_path(@customer.id)
      body = check_response(expected_type: Hash)
      expect(body.keys.sort).must_equal CUSTOMER_FIELDS
    end

    it 'will return a 404 request with JSON for a non-existant customer' do
      get customer_path(-1)

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body['success']).must_equal false
      expect(body['message']).must_equal 'Not found'
    end
  end

end
