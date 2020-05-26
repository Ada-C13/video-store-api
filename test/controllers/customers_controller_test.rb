require "test_helper"

describe CustomersController do
  it "must get index" do
    # get customers_index_url
    # must_respond_with :success

    get customers_path
    must_respond_with :success
    expect(response.header["Content-Type"]).must_include "json"
  end

end
