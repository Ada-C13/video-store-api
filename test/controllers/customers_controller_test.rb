require "test_helper"

describe CustomersController do
  #CUSTOMER_FIELDS = ["id", "name", "registered_at", "address", "city", "state", "postal_code", "phone"].sort
  describe "index" do
    it "includes json and responds with success" do
      get customers_path
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with 200
    end

  end
end
