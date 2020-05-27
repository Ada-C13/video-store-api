require "test_helper"

describe VideosController do
  REQUIRED_VIDEO_FIELDS = ["id", "title", "release_date", "available_inventory", "overview", "total_inventory"].sort

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

      body = check_response(expected_type: Array)

      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal REQUIRED_VIDEO_FIELDS
      end
    end
    it " will response with empty array when there are no videos" do
      Video.destroy_all

      get videos_path
      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Array
      expect(body).must_equal []
    end
  end

  describe "show" do
    
    it "responds to JSON and success and data if at least one exsiting video" do
      existing_video = videos(:video1)
      get video_path(existing_video.id)

      p existing_video.release_date
      body = check_response(expected_type: Hash)
      expect(body.keys.sort).must_equal REQUIRED_VIDEO_FIELDS
      expect(body["id"]).must_equal existing_video.id
      expect(body["title"]).must_equal existing_video.title
      expect(body["release_date"]).must_equal existing_video.release_date.to_s
      expect(body["available_inventory"]).must_equal existing_video.available_inventory
    end
    it "responds with JSON, not found, and errors when looking for now existing path" do
      get video_path(-1)

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["ok"]).must_equal false
      expect(body["errors"]).must_include "Not Found"
    end
  end

    describe "create" do
      let(:video_data){
        {video: 
          {
            title: "Space Jam",
            release_date: Date.new(1999-06-01),
            total_inventory: 10
          }
        }
      }

      it "responds with JSON and created a new video" do
        
        expect {
          post videos_path, params: video_data
        }.must_differ "Video.count", 1

        check_response(expected_type: Hash, expected_status: :created)
      end

      it "will respond with bad_request for invalid" do
        video_data[:video][:title] = nil

        expect {
          post videos_path, params: video_data
        }.wont_change "Video.count"

        body = check_response(expected_type: Hash, expected_status: :bad_request)
        expect(body["errors"].keys).must_include "title" 
      end
    end
end
