require "test_helper"

describe CustomersController do
  it "must get index" do 
    get customers_path 
    must_respond_with :success
    expect(response.header['Content-Type']).must_include 'json'
  end 
  it "will return the proper fields for a list of customer" do 
    customer_field = ['id', 'name', 'registered_at', 'postal_code', 'phone', 'videos_checked_out_count'].sort 
    get customers_path
    body = JSON.parse(response.body)

    expect(body).must_be_instance_of Array 
    
    body.each do |customer|
      expect(customer).must_be_instance_of Hash
      expect(customer.keys.sort).must_equal customer_field
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
