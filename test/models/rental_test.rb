require "test_helper"

describe Rental do
  let(:rental_data) {
    {
      video_id: videos(:frozen).id,
      customer_id: customers(:nataliya).id 
    }
  }

  describe "validations" do
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

  describe "default_values" do
    it "sets default value for active to true" do
      rental = Rental.new(rental_data)
      rental.save

      expect(rental.active).must_equal true
    end

    it "sets default due_date to 7 days from the current date" do
      rental = Rental.new(rental_data)
      rental.save

      expect (rental.due_date).must_equal Date.today + 7.day
    end
  end
end
