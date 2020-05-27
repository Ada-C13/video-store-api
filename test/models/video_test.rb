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


end
