require "test_helper"

describe VideosController do
  INDEX_VIDEO_FIELDS = ["id", "title", "release_date", "available_inventory"].sort
  SHOW_VIDEO_FIELDS = ["title", "overview", "release_date", "total_inventory", "available_inventory"].sort

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do
    it "responds with JSON and success" do
      get videos_path
      check_response(expected_type: Array)
    end

    it "responds with an array of videos hashes" do
      get videos_path
      body = check_response(expected_type: Array)
      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal INDEX_VIDEO_FIELDS
      end
    end

    it "will respond with an empty array when there are no videos" do
      Video.destroy_all
      get videos_path
      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end
  end

  describe "show" do
    it "responds with JSON, success, and video data if the video exists" do
      video = videos(:frozen)
      get video_path(video.id)
      
      body = check_response(expected_type: Hash)
      expect(body.keys.sort).must_equal SHOW_VIDEO_FIELDS
      expect(body["title"]).must_equal video.title
      expect(body["overview"]).must_equal video.overview
      expect(body["release_date"]).must_equal video.release_date.strftime("%Y-%m-%d")
      expect(body["total_inventory"]).must_equal video.total_inventory
      expect(body["available_inventory"]).must_equal video.available_inventory
    end

    it "responds with JSON, not found, and errors if video doesn't exist" do
      get video_path(-1)

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["ok"]).must_equal false
      expect(body["errors"]).must_include "Unable to find the video with id -1"
    end

  end
end
