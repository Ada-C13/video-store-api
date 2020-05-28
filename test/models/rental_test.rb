require "test_helper"

describe Rental do
  describe "validations" do
    let(:rental_data) {
      {
        video_id: videos(:frozen).id,
        customer_id: customers(:nataliya).id 
      }
    }

    it "is valid when video_id and customer_id are present" do
      rental = Rental.new(rental_data)
      expect(rental.valid?).must_equal true
    end

    it "is invalid without a video" do
      rental_data[:video_id] = nil
      rental = Rental.new(rental_data)
      expect(rental.valid?).must_equal false
    end

    it "is invalid without a customer" do
      rental_data[:customer_id] = nil
      rental = Rental.new(rental_data)
      expect(rental.valid?).must_equal false
    end
  end
end
