require "test_helper"

describe CustomersController do
  CUSTOMER_FIELDS = [
    "id",
    "name",
    "registered_at",
    "postal_code",
    "phone",
    "videos_checked_out_count"
].sort
  
  it "must get index" do
    # Act
    get customers_path
    # Assert
    must_respond_with :success
    expect(response.header["Content-Type"]).must_include 'json'
  end

  it "will return all the proper fields for a list of customers" do
    # Act
    get customers_path
    # Assert
    body = JSON.parse(response.body)
    expect(body).must_be_instance_of Array

    body.each do |customer|
      expect(customer).must_be_instance_of Hash
      expect(customer.keys.sort).must_equal CUSTOMER_FIELDS
    end
  end

  it "will return an empty array if no customer exists" do 
    # Act
    Customer.destroy_all
    get customers_path

    # Assert
    body = JSON.parse(response.body)
    must_respond_with :success
    expect(body).must_be_instance_of Array
    expect(body.length).must_equal 0
  end
end
