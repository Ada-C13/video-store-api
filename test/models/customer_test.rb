require "test_helper"

require "test_helper"

describe Customer do

  before do
    @customer = customers(:blathers)
  end

  describe "validations" do
    it "can be recalled/is valid" do
      expect(@customer.valid?).must_equal true
    end

    it "will not save if the name is nil" do
      # Arrange
      @customer.name = nil

      # Assert
      expect(@customer.valid?).must_equal false
      expect(@customer.errors.messages).must_include :name
      expect(@customer.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "will not save if the videos_checked_out_count is nil" do
      # Arrange
      @customer.videos_checked_out_count = nil

      # Assert
      expect(@customer.valid?).must_equal false
      expect(@customer.errors.messages).must_include :videos_checked_out_count
      expect(@customer.errors.messages[:videos_checked_out_count]).must_equal ["can't be blank"]
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

