require "test_helper"

describe RentalsController do
  let(:rental) { rentals(:one) }

  it "should get index" do
    get rentals_url, as: :json
    must_respond_with :success
  end

  it "should create rental" do
    value do
      post rentals_url, params: { rental: {  } }, as: :json
    end.must_differ "Rental.count"

    must_respond_with 201
  end

  it "should show rental" do
    get rental_url(@rental), as: :json
    must_respond_with :success
  end

  it "should update rental" do
    patch rental_url(@rental), params: { rental: {  } }, as: :json
    must_respond_with 200
  end

  it "should destroy rental" do
    value do
      delete rental_url(@rental), as: :json
    end.must_differ "Rental.count", -1

    must_respond_with 204
  end
end
