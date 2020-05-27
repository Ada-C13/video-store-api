require "test_helper"

describe VideosController do
  VIDEO_FIELDS = ["id", "title", "overview", "release_date", "total_inventory", "available_inventory"].sort

  it "must get index" do
    get videos_path
    must_respond_with :success
    expect(response.header["Content-Type"]).must_include "json"
  end

  it "responds with JSON and success" do
    get videos_path

    expect(response.header["Content-Type"]).must_include "json"
    must_respond_with :ok
  end

  it "will return all proper field for all of videos " do
    # Act
    get videos_path

    # getting the body. JSON.parse: command take that json turn into a ruby array or hash.
    body = JSON.parse(response.body)
    #Assert
    expect(body).must_be_instance_of Array
    body.each do |video|
      expect(video).must_be_instance_of Hash
      expect(video.keys.sort).must_equal VIDEO_FIELDS
    end
  end

  it "returns an empty array if not customers exist" do
    Video.destroy_all
    # Act
    get videos_path

    # getting the body. JSON.parse: command take that json turn into a ruby array or hash.
    body = JSON.parse(response.body)
    #Assert
    expect(body).must_be_instance_of Array
    expect(body.length).must_equal 0
  end

  describe "show" do
    #Nominal case
    it "will return a hash with the proper fields for an existing video" do
      video = videos(:video_1)

      get video_path(video.id)
      #act
      must_respond_with :success

      body = JSON.parse(response.body)

      expect(response.header["Content-Type"]).must_include "json"

      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal VIDEO_FIELDS
    end

    it "will return a 404 request with json for a non-existent video" do
      get video_path(-1)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Hash
      expect(body["ok"]).must_equal false
      expect(body["message"]).must_equal "Not found"
    end
  end
end
