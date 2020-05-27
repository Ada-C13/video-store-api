require "test_helper"

describe VideosController do
  VIDEO_FIELDS = ["title", "overview", "release_date", "total_inventory", "available_inventory"].sort

  it "must get index" do
    get videos_path
    must_respond_with :success
    expect(response.header['Content-Type']).must_include 'json'
  end

  it "will return proper fields for a list of videos" do
    get videos_path
    body = JSON.parse(response.body)
    expect(body).must_be_instance_of Array
    
    body.each do |video|
      expect(video).must_be_instance_of Hash
      expect(video.keys.sort).must_equal VIDEO_FIELDS
    end
  end

  it "returns empty array is no videos exist" do
    Video.destroy_all
    get videos_path
    body = JSON.parse(response.body)
    expect(body).must_be_instance_of Array
    expect(body.length).must_equal 0
  end

  it "must get show" do
    get videos_show_url
    must_respond_with :success
  end

  it "must get create" do
    get videos_create_url
    must_respond_with :success
  end

end
