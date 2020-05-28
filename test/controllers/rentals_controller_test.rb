require "test_helper"

describe RentalsController do
  def check_response(expected_type: ,expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  before do
    @customer = customers(:shelley)
    @video = videos(:frozen)
    @video2 = videos(:frozen10) # which has 0 inventory
  end

  let(:new_checkout) {
    {
      customer_id: @customer.id,
      video_id: @video.id,
    }
  }

  let(:invalid_checkout) {
    {
      customer_id: @customer.id,
      video_id: @video2.id,
    }
  }

  describe "checkout action" do

    it "be able to create a checkout" do
      expect{ post checkout_path, params: new_checkout}.must_differ "Rental.count", 1
      must_respond_with :success
    end

    it "return no found if video id is invalid" do
      new_checkout[:video_id] = nil

      expect { post checkout_path, params: new_checkout}.wont_change "Rental.count"

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_equal ['Not Found']
      must_respond_with :not_found
    end

    it "return no found if customer id is invalid" do
      new_checkout[:customer_id] = nil

      expect { post checkout_path, params: new_checkout}.wont_change "Rental.count"

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_equal ['Not Found']
      must_respond_with :not_found
    end

    it "return no found if avaliable inventory < 1 " do

      expect { post checkout_path, params: invalid_checkout}.wont_change "Rental.count"

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_equal ['Not Found']
      must_respond_with :not_found
    end


  end



  describe "checkin action" do
    it "be able to edit a existing rental using checkin" do
      # Act
      post checkout_path, params: new_checkout
      # Assert
      expect { post checkin_path, params: new_checkout}.wont_change "Rental.count"
      must_respond_with :success
    end

    it "will return no found if the rental doesn't exist " do
      # Act
      post checkin_path, params: new_checkout
      # Arrange
      body = check_response(expected_type: Hash, expected_status: :not_found)
      # Assert
      expect(body["errors"]).must_equal ['Not Found']
      must_respond_with :not_found
    end
  end
end
