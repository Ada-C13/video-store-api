require "test_helper"

describe VideosController do
  REQUIRED_ATTRS = ["title", "overview", "release_date", "total_inventory", "available_inventory"].sort

  describe "index" do 
    it "responds with JSON and success" do
      get videos_path

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "responds with an array of video info" do
      get videos_path

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Array

      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal REQUIRED_ATTRS
      end
    end

    it "will give back an empty array if no videos" do
      Video.destroy_all

      get videos_path
      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Array
      expect(body).must_be_empty
    end
  end

  describe "show" do
    it "responds with JSON and success" do
      video = videos(:fake_vid)
      get video_path(video.id)

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "will return a hash of correct information for existing video" do
      video = videos(:fake_vid)
      get video_path(video.id)

      must_respond_with :success

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal REQUIRED_ATTRS
    end

    it "will return a 404 in JSON for non-existent video" do
      get video_path(-1)

      must_respond_with :not_found

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Hash
      expect(body['ok']).must_equal false
      expect(body['message']).must_equal 'Not Found'
    end
  end

end
