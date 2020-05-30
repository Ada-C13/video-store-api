require "test_helper"

describe Video do
  let(:video) { Video.new(
      title: "a", 
      overview: "this is a transformative movie", 
      release_date: "2020-01-01", 
      total_inventory: 20,
      available_inventory: 19
    ) }
  describe "valid creation" do
    it "must have assigned fields" do 
      expect(video.title).must_equal "a"
      expect(video.overview).must_equal "this is a transformative movie"
      expect(video.release_date).must_equal "2020-01-01"
      expect(video.total_inventory).must_equal 20
      expect(video.available_inventory).must_equal 19
    end

    it "must be valid" do 
      result = video.valid?
      expect(result).must_equal true
    end

    it "can have rentals" do
      rentals = []
      3.times do |n|
        rentals << Rental.create(customer_id: n, video_id: video.id)
      end
      video.rentals = rentals
      expect(video.rentals[0].video_id).must_equal video.id
    end

  end
  describe "presence validation" do
    it "is invalid if title is missing" do
      video.title = nil
      result = video.valid?
      expect(result).must_equal false
    end
    it "is invalid if overview is missing" do
      video.overview = nil
      result = video.valid?
      expect(result).must_equal false
    end
    it "is invalid if release_date is missing" do
      video.release_date = nil
      result = video.valid?
      expect(result).must_equal false
    end
    it "is invalid if total_inventory is missing" do
      video.total_inventory = nil
      result = video.valid?
      expect(result).must_equal false
    end
    it "is invalid if available_inventory is missing" do
      video.available_inventory = nil
      result = video.valid?
      expect(result).must_equal false
    end
  end
end

