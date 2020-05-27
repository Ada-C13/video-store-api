require "test_helper"

describe CustomersController do
  it "must get index" do
    get customers_path

    must_respond_with :success
    # insure it's returning JSON
    expect(response.header['Content-Type']).must_include 'json'
  end

  it "will return all the proper fields for a list of customers" do
    customer_fields = ["id", "name", "registered_at", "address", "city", "state", "postal_code", "phone"].sort

    # Act
    get customers_path

    # Get body of the response
    # as an array or hash - depending on what it is in the JSON
    body = JSON.parse(response.body)

    # Assert
    expect(body).must_be_instance_of Array

    # loop through Array of Hashes 
    body.each do |customer|
      # each individual Hash
      expect(customer).must_be_instance_of Hash
      # must match expected customer fields listed above
      expect(customer.keys.sort).must_equal customer_fields
    end
  end

    it "returns an empty array if no customers exist" do 
      Customer.destroy_all

      # Act
      get customers_path

      # Get body of the response
      # as an array or hash - depending on what it is in the JSON
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0
    end
    
end # describe CustomersController end
