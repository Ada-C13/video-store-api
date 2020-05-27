require "test_helper"

describe VideosController do
  VIDEO_FIELDS = ["id", "title", "overview", "release_date", "total_inventory", "available_inventory"]

  it "must get index" do
    get videos_path

    must_respond_with :success
    expect(response.header['Content-Type']).must_include 'json'
  end

  it "will return all the proper fields for a list of videos" do

    get videos_path

    body = JSON.parse(response.body)

    expect(body).must_be_instance_of Array

    body.each do |video|
      expect(video).must_be_instance_of Hash
      expect(video.keys.sort).must_equal VIDEO_FIELDS
    end
  end

  


  # it "must get show" do
  #   get videos_show_url
  #   must_respond_with :success
  # end

  # it "must get create" do
  #   get videos_create_url
  #   must_respond_with :success
  # end

end
