require "test_helper"

describe Rental do
  let(:rental_fixture) {rental(:rental_1)}
  let(:customer_fixture) {customer(:customer_1)}
  let(:video_fixture) {video(:video_1)}
  
  describe "valid creation" do
    it "must have assigned fields" do 
      expect(rental_fixture.customer_id).must_equal customer_fixture.id
      expect(rental_fixture.video_id).must_equal video_fixture.id
    end

    it "must be connected to customer" do
      expect(rental_fixture.customer.id).must_equal customer_fixture.id
    end

    it "must be connected to video" do
      expect(rental_fixture.video.id).must_equal video_fixture.id
    end
    # it "must be valid" do 
    #   value(rental_fixture).must_be :valid?
    # end
    it "must be valid" do
      result = rental_fixture.valid?
      expect(result).must_equal true
    end
  end
  describe "presence validation" do
    it "is invalid if customer_id is missing" do
      rental_fixture.customer_id = nil
      result = rental_fixture.valid?
      expect(result).must_equal false
    end
    it "is invalid if video_id is missing" do
      rental_fixture.video_id = nil
      result = rental_fixture.valid?
      expect(result).must_equal false
    end
    
  end
  
end
