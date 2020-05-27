require "test_helper"

describe Video do
  before do
    @video = Video.new(title: "Somthign", overview: "Somthing", release_date: 2017-03-14, total_inventory: 4, available_inventory: 5)
  end

  it "video can be instantiated" do
    expect(@video.valid?).must_equal true
  end

  it "video will have the required field" do
    [:id, :title, :overview, :release_date, :total_inventory, :available_inventory].each do |field|
      expect(@video).must_respond_to field
    end
  end

  describe "validations" do
    it "it's invalid when video does't have title" do
      @video.title = nil
      expect(@video.valid?).must_equal false
      expect(@video.errors.messages).must_include :title
      expect(@video.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "it's valid when video has title" do
      @video.title = "Somthing"
      expect(@video.valid?).must_equal true
    end

    it "it's invalid when video does't have overview" do
      @video.overview = nil
      expect(@video.valid?).must_equal false
      expect(@video.errors.messages).must_include :overview
      expect(@video.errors.messages[:overview]).must_equal ["can't be blank"]
    end

    it "it's valid when video has overview" do
      @video.overview = "Somthing"
      expect(@video.valid?).must_equal true
    end
  end


end
