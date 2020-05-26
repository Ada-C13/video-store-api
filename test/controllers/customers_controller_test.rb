require "test_helper"

describe CustomersController do
  it "must get index" do
    get customers_path

    must_respond_with :success
    expect(response.header['Content-Type']).must_include 'json'
  end

  it "will return all the proper fields for a list of customers" do
    customer_fields =  ["name", "registered_at", "address", "city", "state", "postal_code", "phone", "videos_checked_out_count"].sort
    # Act
    get customers_path

    # Get the body as an array or a hash
    body = JSON.parse(response.body)

    # Assert
    expect(body).must_be_instance_of Array
    body.each do |customer|
      expect(customer).must_be_instance_of Hash
      expect(customer.keys.sort).must_equal customer_fields
    end
  end

  it "returns an empty array if no customers exist" do
    # Arrange
    Customer.destroy_all
    # Act
    get customers_path

    # Get the body as an array or a hash
    body = JSON.parse(response.body)

    # Assert
    expect(body).must_be_instance_of Array
    expect(body.length).must_equal 0
  end
end
