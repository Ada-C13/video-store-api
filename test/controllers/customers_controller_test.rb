require "test_helper"

describe CustomersController do
  it "must get index for customers" do
    get customers_path

    must_respond_with :ok
    expect(response.header["Content-Type"]).must_include "json"
  end

  it "will return all the proper fields a list of customers" do
    customer_fields = ["id", "name", "registered_at", "postal_code", "phone", "videos_checked_out_count"].sort

    get customers_path

    body = JSON.parse(response.body)

    expect(body).must_be_instance_of Array
    body.each do |customer|
      expect(customer).must_be_instance_of Hash
      expect(customer.keys.sort).must_equal customer_fields
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
