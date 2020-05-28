require "test_helper"

describe CustomersController do
  it "responds with JSON and success" do
    get customers_path

    expect(response.header['Content-Type']).must_include 'json'
    must_respond_with :ok
  end

  it "must get index" do
    get customers_path
    must_respond_with :success
  end

  it "responds with an array of customer hashes" do
    # Act
    get customers_path

    # Get the body of the response
    body = JSON.parse(response.body)

    # Assert
    expect(body).must_be_instance_of Array
    body.each do |customer|
      expect(customer).must_be_instance_of Hash

      required_cust_attrs = ["name", "address", "city", "state", "postal_code", "videos_checked_out_count", "phone"]

      expect(customer.keys.sort).must_equal required_cust_attrs.sort
    end
  end

  it "will respond with an empty array when there are no customers" do
    # Arrange
    Customer.destroy_all

    # Act
    get customers_path
    body = JSON.parse(response.body)

    # Assert
    expect(body).must_be_instance_of Array
    expect(body).must_equal []
  end
end
