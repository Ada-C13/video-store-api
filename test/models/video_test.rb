require "test_helper"

describe Video do

  before do
    @valid_video = videos(:valid_video)
  end

  describe "validations" do
    it "can be recalled/is valid" do
      expect(@valid_video.valid?).must_equal true
    end

    it "will not save if the title is nil" do
      # Arrange
      @valid_video.title = nil

      # Assert
      expect(@valid_video.valid?).must_equal false
      expect(@valid_video.errors.messages).must_include :title
      expect(@valid_video.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "will not save if the available_inventory is nil" do
      # Arrange
      @valid_video.available_inventory = nil

      # Assert
      expect(@valid_video.valid?).must_equal false
      expect(@valid_video.errors.messages).must_include :available_inventory
      expect(@valid_video.errors.messages[:available_inventory]).must_equal ["can't be blank"]
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

end
