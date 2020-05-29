require "test_helper"

describe Customer do
  describe "validations" do
    before do
      @customer = customers(:Kenji)
    end

    it "is invalid when address is missing" do
      @customer.address = nil

      result = @customer.valid?
      expect(result).must_equal false
      expect(@customer.errors.messages).must_include :address
    end

    describe "custom methods" do
      describe "checked_out_movie" do
        it "will increase checked_out_movie by one" do
          expect{ customer.checked_out_movie }.must_differ "customer.checked_out_count", 1
        end
      end
  
      describe "checked_in_movie" do
        it "will decrease movies_checked_out_count by one" do
          expect{ customer.checked_in_movie }.must_differ "customer.checked_out_count", -1
        end
      end
    end




  end
end
