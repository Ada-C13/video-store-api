require "test_helper"

describe CustomersController do
  before do
    @customer_fields = ["id", "name", "registered_at", "postal_code", "phone", "videos_checked_out_count"].sort
  end
  describe "index" do
    it "responds with JSON and a status of 'ok'" do
      get customers_path

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "will return all the proper fields for a list of customers" do
      get customers_path

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 9

      body.each do |customer_hash|
        expect(customer_hash).must_be_instance_of Hash
        expect(customer_hash.keys.sort).must_equal @customer_fields
      end
    end

    it "returns an empty array if no customers exist" do
      Customer.destroy_all

      get customers_path

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0
    end
  end
end
