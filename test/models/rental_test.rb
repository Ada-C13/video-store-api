require "test_helper"

describe Rental do
  before do
    @blathers = customers(:blathers)
    @valid_video = videos(:valid_video)

    @museumrental = rentals(:museumrental)
  end

  describe "validations" do
    it "can be recalled/is valid" do
      expect(@museumrental.valid?).must_equal true
    end

    it "can be created when video_id and customer_id are present" do
      new_rental = Rental.new(
        customer: @blathers,
        video: @valid_video
      )

      expect(new_rental.valid?).must_equal true
    end

    it "cannot create a new rental when video_id is not present" do
      new_rental = Rental.new(customer: @blathers)

      expect(new_rental.valid?).must_equal false
    end

    it "cannot create a new rental when customer_id is not present" do
      new_rental = Rental.new(video: @valid_video)

      expect(new_rental.valid?).must_equal false
    end
  end

  describe "relationships" do
    before do
      @valid_video = videos(:valid_video)
      @customer = customers(:blathers)

      rentals(:museumrental)
    end

    it "can establish many to many relationship between videos and customers" do
      expect(@customer.rentals.length).must_equal 1
      expect(@customer.videos.length).must_equal 1

      expect(@customer.videos[0].id).must_equal @valid_video.id
    end
  end

end


