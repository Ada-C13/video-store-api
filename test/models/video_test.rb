require "test_helper"

describe Video do
  describe "validations" do 
    it "is valid when all fields are present" do 
      # Act
      result = videos(:joker).valid?

      # Assert
      expect(result).must_equal true
    end 

    it "is not valid when any field is absent" do 
      # Arrange
      invalid_video = Video.new()

      # Act
      result = invalid_video.valid?

      # Assert
      expect(result).must_equal false
      expect(invalid_video.errors.messages).must_include :title
      expect(invalid_video.errors.messages).must_include :overview
      expect(invalid_video.errors.messages).must_include :release_date
      expect(invalid_video.errors.messages).must_include :total_inventory
      expect(invalid_video.errors.messages).must_include :available_inventory
    end 
  end
end
