require "test_helper"

describe Customer do
  before do 
    @customer = customers(:customer_one)
  end

  describe "check_out_increase" do
    it "will increase videos_checked_out_count" do 
      count_before = @customer.videos_checked_out_count
      @customer.check_out_increase
      count_after = @customer.videos_checked_out_count

      expect(count_after).must_equal count_before + 1
    end
  end

  describe "check_in_decrease" do 
    it "will decrease videos_checked_out_count" do
      count_before = @customer.videos_checked_out_count
      @customer.check_in_decrease
      count_after = @customer.videos_checked_out_count

      expect(count_after).must_equal count_before - 1
    end
  end
end