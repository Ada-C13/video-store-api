require "test_helper"

describe Customer do
  CUSTOMER_FIELDS = ["id", "name", "registered_at", "address", "city", "state", "postal_code", "phone"].sort
  
  it "includes json and responds with success" do 
    get customers_path

    expect(response.header['Content-Type']).must_include 'json'
    must_respond_with :success 
  end

end
