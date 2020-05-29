require "test_helper"

describe Customer do
  let (:shelley) { customers(:customer_1) }

  describe "Validation" do
    it "requires name, address, city, state, postal_code, phone, registered_at" do
      required_fields = [:name, :address, :city, :state, :postal_code, :phone, :registered_at]

      required_fields.each do |field|
        shelley[field] = nil

        expect(shelley.valid?).must_equal false

        shelley.reload
      end
    end
  end

  describe "Relationship" do
    it "has rental" do
      shelley.must_respond_to :rentals
    end

    it "customer has video " do
      shelley.must_respond_to :videos
    end
  end
end
