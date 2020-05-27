require "test_helper"

describe Video do
  before do
    @video = Video.new(title: "Somthign", overview: "Somthing", release_date: 2017-03-14, total_inventory: 4, available_inventory: 5)
  end

  it "Video can be instantiated" do
    expect(@video.valid?).must_equal true
  end


end
