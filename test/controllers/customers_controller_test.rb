require "test_helper"

CUSTOMER_FIELDS = ["id", "name", "registered_at", "postal_code", "phone", "videos_checked_out_count"].sort

describe CustomersController do

  it "must get index" do 
    get customers_path
    must_respond_with :success
    expect(response.header["Content-Type"]).must_include "json"
  end

  it "must return all customer fields" do
    get customers_path
    body = JSON.parse(response.body)
    expect(body).must_be_instance_of Array

    body.each do |customer|
      expect(customer).must_be_instance_of Hash 
      expect(customer.keys.sort).must_equal CUSTOMER_FIELDS 
    end
  end

  it "responds with expected type and status" do
    get customers_path
    must_respond_with :ok
    expect(response.header["Content-Type"]).must_include "json"
  end

  it "returns an empty array if database has no customers" do
    Customer.destroy_all
    get customers_path
    body = JSON.parse(response.body)
    expect(body).must_be_instance_of Array
    expect(body.length).must_equal 0
  end

end
