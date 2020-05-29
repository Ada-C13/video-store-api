require "test_helper"

describe Video do
  let(:video1) { videos(:video1) }

  describe "validations" do
    it "is valid when all fields are present" do
      # Act
      result = video1.valid?

      # Assert
      expect(result).must_equal true
    end

    it "is invalid without a title" do
      # Arrange
      video1.title = nil

      # Act
      result = video1.valid?

      # Assert
      expect(result).must_equal false
    end

    it "is invalid without a overview" do
      # Arrange
      video1.overview = nil

      # Act
      result = video1.valid?

      # Assert
      expect(result).must_equal false
    end

    it "is invalid without a release date" do
      # Arrange
      video1.release_date = nil

      # Act
      result = video1.valid?

      # Assert
      expect(result).must_equal false
    end

    it "is invalid without a total inventory" do
      # Arrange
      video1.total_inventory = nil

      # Act
      result = video1.valid?

      # Assert
      expect(result).must_equal false
    end

    it "is invalid without a available inventory" do
      # Arrange
      video1.available_inventory = nil

      # Act
      result = video1.valid?

      # Assert
      expect(result).must_equal false
    end
  end
end
