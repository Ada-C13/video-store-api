require "test_helper"

describe VideosController do
  VIDEO_FIELDS = ["id", "title", "overview", "total_inventory", "available_inventory", "release_date"].sort

  describe "index" do
    it "must get index" do
      get videos_path
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "will return all proper fields for a list of customers" do
      get videos_path

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Array

      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal VIDEO_FIELDS
      end
    end

    it "returns an empty array if no customers exist" do
      Video.destroy_all

      get videos_path

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0
    end
  end

  describe "show" do
    it "will return a hash with the proper fields for an existing video" do
      video = videos(:jurassicpark)
      # act
      get video_path(video.id)
      body = JSON.parse(response.body)
      must_respond_with :ok
      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal VIDEO_FIELDS
    end

    it "will return a 404 request with json for a non-existant pet" do
      get video_path(-1)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body['ok']).must_equal false
      expect(body['message']).must_equal 'Not found'
    end

  end
end
