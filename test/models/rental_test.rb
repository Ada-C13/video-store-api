require "test_helper"

describe Rental do
  describe "validation" do
    let(:rental) { rentals(:rental_1) }

    it "must be valid" do
      expect(rental.valid?).must_equal true
    end
    it "wont be valid without a title" do
      required_fields = [:customer_id, :video_id, :due_date, :checked_out_date]

      rental = Rental.new
      expect(rental.valid?).must_equal false
      expect(rental.errors[:checked_in_date].count.zero?).must_equal true

      required_fields.each do |field|
        expect(rental.errors[field].count.positive?).must_equal true
      end
    end
  end
end
