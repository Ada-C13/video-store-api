require "test_helper"

describe CustomersController do
  CUSTOMER_FIELDS = ["id", "name", "registered_at", "address", "city", "state", "postal_code", "phone"].sort
  
  it "includes json and responds with success" do 
    get customers_path

    expect(response.header['Content-Type']).must_include 'json'
    must_respond_with :success 
  end

  it "will return all the proper fields for a list of customers" do 
    get customers_path 

    body = JSON.parse(response.body)

    expect(body).must_be_instance_of Array 

    body.each do |customer|
      expect(customer).must_be_instance_of Hash 
      expect(customer.keys.sort).must_equal CUSTOMER_FIELDS
    end
  end
  
  
end
