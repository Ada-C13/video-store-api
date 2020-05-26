require "test_helper"

describe Video do
  before do
    @video = videos(:vid1)
  end

  it "can be instantiated" do
    # Arrange
    new_video = Video.new(
      title: "Test video",
      overview: "Test overview",
      release_date: "2015-04-29T14:54:14.000Z",
      total_inventory: 5,
      available_inventory: 1
      )
    new_video.save
    # Assert
    expect(Video.last).must_equal new_video
  end

  it "has the required fields" do
    # Arrange
    @video

    # Assert
    [:title, :overview, :release_date, :total_inventory, :available_inventory].each do |f|
      
      # Assert
      expect(@video).must_respond_to f
    end

    expect(@video.created_at).wont_be_nil
  end

  describe 'validations' do
    it "is valid when all fields are filled" do
      result = @video.valid?
      expect(result).must_equal true
    end

    it 'fails validation when fields are nil' do
      new_video = Video.new
      new_video.save
  
      expect(new_video.valid?).must_equal false

      [:title, :overview, :release_date, :total_inventory, :available_inventory].each do |f|
      # Assert
        expect(new_video.errors.messages.include?(f)).must_equal true
        expect(new_video.errors.messages[f].include?("can't be blank")).must_equal true
      end
    end
  end
end
