require "test_helper"

describe Video do
  let(:video) { videos(:Jumanji) }

  describe "validations" do
    it "is valid when all required fields are present" do
      expect(video.valid?).must_equal true
    end

    it "is invalid with a field is missing" do
      video.title = nil
      expect(video.valid?).must_equal false
    end
  end
end
