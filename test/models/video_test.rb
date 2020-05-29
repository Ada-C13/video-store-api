require "test_helper"

describe Video do
  before do
    @video = videos(:firstvideo)
  end
  
  describe "validations" do
    it "must have required fields" do
      result = @video.valid?
      expect(result).must_equal true
    end
    it "must fail if nil" do
      @video.title = nil
      expect(@video.valid?).must_equal false
    end
  end
end