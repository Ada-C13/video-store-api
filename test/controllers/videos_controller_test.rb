require "test_helper"

describe VideosController do
  VIDEO_FIELD = ["overview", "title", "release_date", "available_inventory", "total_inventory"].sort
  describe "index" do
    it "must get index for videos" do
      get videos_path

      must_respond_with :ok
      expect(response.header["Content-Type"]).must_include "json"
    end
    it "will return all the proper fields a list of videos" do
      get videos_path

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Array
      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal VIDEO_FIELD
      end
    end
    it "will return an empty array if no videos exist" do
      Video.destroy_all

      get videos_path

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0
    end
  end

  describe "show" do
    it "will return a hash with the proper fields for an existing video" do
      video = videos(:funny_video)

      get video_path(video.id)

      body = JSON.parse(response.body)
      must_respond_with :ok
      expect(response.header["Content-Type"]).must_include "json"
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal VIDEO_FIELD
    end
    it "will return a 404 request with a json for a non-existing video" do
      get video_path(-1)
      must_respond_with :not_found

      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body["errors"]).must_equal ["Not Found"]
    end
  end
  describe "create" do
    let(:video_params) {
      {
        title: "jarred's lecture",
        overview: "jarred lecturing on the show action",
        release_date: "May 26, 2020",
        total_inventory: 4,
        available_inventory: 4,
      }
    }

    it "it can create a new video" do
      expect { post videos_path, params: video_params }.must_differ "Video.count", 1
      must_respond_with :created
    end
    it "gives a bad_request status when a user gives bad data" do
      video_params[:title] = nil

      expect { post videos_path, params: video_params }.wont_change "Video.count"
      must_respond_with :bad_request
      expect(response.header["Content-Type"]).must_include "json"
      body = JSON.parse(response.body)
      expect(body["errors"].keys).must_include "title"
    end
  end
end
