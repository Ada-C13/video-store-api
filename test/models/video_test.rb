require "test_helper"

describe Video do
  let(:video) { videos(:Jumanji) }

  describe "validations" do
    it "is valid when all required fields are present" do
      expect(video.valid?).must_equal true
    end

    it "is invalid when title is missing" do
      video.title = nil
      expect(video.valid?).must_equal false
    end

    it "is invalid when overview is missing" do
      video.overview = nil
      expect(video.valid?).must_equal false
    end

    it "is invalid when release date is missing" do
      video.release_date = nil
      expect(video.valid?).must_equal false
    end

    it "is invalid when total inventory is missing" do
      video.total_inventory = nil
      expect(video.valid?).must_equal false
    end
  end
end
