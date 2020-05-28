require "test_helper"

describe CustomersController do
  it "must get index for customers" do 
    get customers_path

    must_respond_with :ok
    expect(response.header['Content-Type']).must_include 'json' 
  end

end
