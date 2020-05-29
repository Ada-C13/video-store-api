require "test_helper"

describe Video do

  describe "validations" do 
    before do 
      @video = videos(:testvideo)
    end 

    it "is valid when title is present" do 
      result = @video.valid? 

      expect(result).must_equal true 

    end 

    it "will not create video if title is nil" do 
      @video.title = nil 
      result = @video.valid?

      expect(result).must_equal false 
      expect(@video.errors).wont_be_empty  
      expect(@video.errors.messages[:title].include?("can't be blank") ).must_equal true 
    end 

  end 
end
