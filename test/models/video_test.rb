require "test_helper"

describe Video do

  let (:new_video) {
    Video.new(
      title: 'New Video', 
	    overview: 'Test video has a test description.',
	    release_date: '2020-01-01',
	    total_inventory: 10,
	    available_inventory: 10,
    )
  }

  it "can be instantiated" do
    # Assert
    expect(new_video.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_video.save
    find_video = Video.first
    [:title, :overview, :release_date, :total_inventory, :available_inventory].each do |field|
      # Assert
      expect(find_video).must_respond_to field
    end
  end

  describe "validations" do
    it "must have a title" do
      new_video.title = nil

      # Assert
      expect(new_video.valid?).must_equal false
      expect(new_video.errors.messages).must_include :title
      expect(new_video.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a overview" do
      new_video.overview = nil

      # Assert
      expect(new_video.valid?).must_equal false
      expect(new_video.errors.messages).must_include :overview
      expect(new_video.errors.messages[:overview]).must_equal ["can't be blank"]
    end

    it "must have a release_date" do
      new_video.release_date = nil

      # Assert
      expect(new_video.valid?).must_equal false
      expect(new_video.errors.messages).must_include :release_date
      expect(new_video.errors.messages[:release_date]).must_equal ["can't be blank"]
    end

    it "must have a total_inventory" do
      new_video.total_inventory = nil

      # Assert
      expect(new_video.valid?).must_equal false
      expect(new_video.errors.messages).must_include :total_inventory
      expect(new_video.errors.messages[:total_inventory]).must_equal ["can't be blank"]
    end

    it "must have a available_inventory" do
      new_video.available_inventory = nil

      # Assert
      expect(new_video.valid?).must_equal false
      expect(new_video.errors.messages).must_include :available_inventory
      expect(new_video.errors.messages[:available_inventory]).must_equal ["can't be blank"]
    end
  end
end
