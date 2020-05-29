require "test_helper"

describe CustomersController do
  CUSTOMER_FIELDS = ["id", "name", "registered_at", "postal_code", "phone", "videos_checked_out_count"].sort

  it "must get index" do
    # Act
    get customers_path

    must_respond_with :success

    # Assert
    # insure it's returning JSON
    expect(response.header['Content-Type']).must_include 'json'
  end

  it "will return all the proper fields for a list of customers" do
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
      expect(customer.keys.sort).must_equal CUSTOMER_FIELDS
    end
  end

    it "returns an empty array if no customers exist" do 
      Customer.destroy_all

      # Act
      get customers_path

      # Get body of the response
      # as an array or hash - depending on what's in the JSON
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0
    end

    describe "show" do 
      # Nominal
      it "will return a hash with the proper fields for an existing customer" do 
        customer = customers(:charli)
        
        # Act
        get customer_path(customer.id)

        # Assert
        must_respond_with :success


        body = JSON.parse(response.body)

        expect(response.header['Content-Type']).must_include 'json'

        expect(body).must_be_instance_of Hash
        expect(body.keys.sort).must_equal CUSTOMER_FIELDS

      end

      # Edge Case
      it "will return a 404 request with json for a non-existent customer" do 
        get customer_path(-1)

        must_respond_with :not_found
        body = JSON.parse(response.body)
        expect(body).must_be_instance_of Hash
        expect(body['ok']).must_equal false
        expect(body['message']).must_equal 'Not found'
      end
    end #describe show end
end # describe CustomersController end
