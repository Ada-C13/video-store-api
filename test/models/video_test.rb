require "test_helper"

describe Video do
  describe "validations" do
    let(:video_data) {
      {
        video: {
          title: "Cinderella",
          overview: "After her father unexpectedly dies, young Ella (Lily James) finds herself at the mercy of her cruel stepmother (Cate Blanchett) and stepsisters, who reduce her to scullery maid. Despite her circumstances, she refuses to despair.",
          release_date: "2015-03-06",
          total_inventory: 5,
          available_inventory: 5
        }
      }
    }
    
    it "is valid when all fields are present" do
      video = Video.new(video_data[:video])
      expect(video.valid?).must_equal true
    end

    it "is invalid without a title" do
      video_data[:video][:title] = nil
      video = Video.new(video_data[:video])
      expect(video.valid?).must_equal false
    end

    it "is invalid without an overview" do
      video_data[:video][:overview] = nil
      video = Video.new(video_data[:video])
      expect(video.valid?).must_equal false
    end

    it "is invalid without a release_date" do
      video_data[:video][:release_date] = nil
      video = Video.new(video_data[:video])
      expect(video.valid?).must_equal false
    end

    it "is invalid without a total_inventory" do
      video_data[:video][:total_inventory] = nil
      video = Video.new(video_data[:video])
      expect(video.valid?).must_equal false
    end

    it "is invalid without a available_inventory" do
      video_data[:video][:available_inventory] = nil
      video = Video.new(video_data[:video])
      expect(video.valid?).must_equal false
    end

    it "total_inventory should be an integer larger than 0" do
      video_data[:video][:total_inventory] = "I don't know!"
      video = Video.new(video_data[:video])
      expect(video.valid?).must_equal false

      video_data[:video][:total_inventory] = 0
      video = Video.new(video_data[:video])
      expect(video.valid?).must_equal false

      video_data[:video][:total_inventory] = 1
      video = Video.new(video_data[:video])
      expect(video.valid?).must_equal true
    end

    it "available_inventory should be an integer 0 or larger" do
      video_data[:video][:available_inventory] = "I don't know!"
      video = Video.new(video_data[:video])
      expect(video.valid?).must_equal false

      video_data[:video][:available_inventory] = -9
      video = Video.new(video_data[:video])
      expect(video.valid?).must_equal false

      video_data[:video][:available_inventory] = 0
      video = Video.new(video_data[:video])
      expect(video.valid?).must_equal true
    end
  end
end
