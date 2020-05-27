require "test_helper"

describe RentalsController do
  it "must get check-in" do
    get rentals_check-in_url
    must_respond_with :success
  end

  it "must get check-out" do
    get rentals_check-out_url
    must_respond_with :success
  end

end
