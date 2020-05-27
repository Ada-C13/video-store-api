require "test_helper"

describe CustomersController do
  customer_fields = ["id", "name", ]
  describe "index" do
    it "must get index" do
      get customers_path
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "responds with customer data" do
      get customers_path
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      body.each do |customer|
        expect(customer).must_be_instance_of Hash
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
