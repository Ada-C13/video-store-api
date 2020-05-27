require "test_helper"

describe CustomersController do
  #CUSTOMER_FIELDS = ["id", "name", "registered_at", "address", "city", "state", "postal_code", "phone"].sort
  describe "index" do
    it "includes json and responds with success" do
      get customers_path
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with 200
    end

    it "responds with customer data" do
      get customers_path
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        #expect(customer.keys.sort).must_equal CUSTOMER_FIELDS
      end
    end

    it "responds with an empty array when there are no customers" do
      Customer.destroy_all
      get customers_path
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0
      expect(body).must_equal []
      
    end
  end
end
