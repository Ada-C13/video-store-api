require "test_helper"


describe Video do
  let(:video) { videos(:video_1) }

  it "must be valid" do
    expect(video.valid?).must_equal true
  end

  it "wont be valid without a title" do
    video.title = ""
    expect(video.valid?).must_equal false
  end

  
  it "Shelley Rocha an associated customer" do
    expect(video).must_respond_to :customers
    expect(video.customers).must_include customers(:customer_1)
  end

  it "can have an associated rental" do
    expect(video).must_respond_to :rentals
    expect(video.rentals).must_include rentals(:rental_1)
  end

end










