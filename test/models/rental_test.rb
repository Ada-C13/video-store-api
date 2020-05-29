require "test_helper"

describe Rental do
  let(:customer) { customers(:Jane) }
  let(:video_with_stock) { videos(:Underwater) }
  let(:video_with_no_stock) { videos(:Shrek) }
  describe "validations" do
    it "Rental is valid when created with a movie with available stock" do
      rental = Rental.new(
        video_id: video_with_stock.id,
        customer_id: customer.id)
        expect(rental.valid?).must_equal true
    end

    it "Rental is invalid when creating with a movie with no available stock" do
      rental = Rental.new(
        video_id: video_with_no_stock.id,
        customer_id: customer.id)
        expect(rental.valid?).must_equal false
    end
  end
end
