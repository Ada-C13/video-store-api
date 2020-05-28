require "test_helper"

describe Rental do
  describe "validations" do 
    before do 
      @rental = Rental.create(
        customer_id: customers(:customer_one).id,
        video_id: videos(:fake_vid).id,
        due_date: Date.today + 7
      )
    end

    it "is valid when all fields are present" do 
      result = @rental.valid?

      expect(result).must_equal true
    end

    it "is invalid without a customer_id" do 
      @rental.customer_id = nil 

      result = @rental.valid?

      expect(result).must_equal false
    end

    it "is invalid without a video_id" do 
      @rental.video_id = nil 

      result = @rental.valid?

      expect(result).must_equal false
    end

    it "is invalid without a due_date" do 
      @rental.due_date = nil 

      result = @rental.valid?

      expect(result).must_equal false
    end
  end
end
