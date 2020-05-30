require "test_helper"

describe VideosController do

  REQUIRED_INDEX_VIDEO_FIELDS = ["id", "title", "release_date", "available_inventory"].sort
  REQUIRED_SHOW_VIDEO_FIELDS = ["title", "overview", "release_date", "total_inventory", "available_inventory"].sort

  # helper method
  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do
    it "responds with JSON and success" do
      # Act 
      get videos_path
      
      # Assert
      check_response(expected_type: Array)
    end

    it "responds with an array of video hashes" do
      # Act 
      get videos_path

      # Assert
      body = check_response(expected_type: Array)

      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.keys.sort).must_equal REQUIRED_INDEX_VIDEO_FIELDS
      end
    end
    
    it "will respond with an empty array when there are no Videos" do
      # Arrange
      Video.destroy_all

      # Act
      get videos_path

      # Assert
      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end 
  end

  describe "show" do
    it "responds with JSON, success, and specific video data when looking for one existing video" do
      # Arrange
      existing_video = videos(:joker) # see videos.yml

      # Act
      get video_path(existing_video.id)
      
      # Assert
      body = check_response(expected_type: Hash)
      expect(body.keys.sort).must_equal REQUIRED_SHOW_VIDEO_FIELDS
      expect(body["title"]).must_equal existing_video.title
      expect(body["overview"]).must_equal existing_video.overview
      expect(body["release_date"]).must_equal existing_video.release_date.strftime("%Y-%m-%d")
      expect(body["total_inventory"]).must_equal existing_video.total_inventory
      expect(body["available_inventory"]).must_equal existing_video.available_inventory
    end
  
    it "responds with not found error when looking for non-existent video" do
      get video_path(-1)

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_include "Not Found"
    end
  end

  describe "create" do 
    let (:valid_video){
      {
        title: "A New Hope",
        overview: "cool movie",
        release_date: Date.today,
        total_inventory: 5,
        available_inventory: 1
      }
    }

    let (:invalid_video){
      {
        title: nil,
        overview: nil,
        release_date: nil,
        total_inventory: nil,
        available_inventory: nil
      }
    }
  
    it "can create a new video that includes all valid data" do 
      expect {
        post videos_path, params: valid_video
      }.must_differ "Video.count", 1

      check_response(expected_type: Hash, expected_status: :created)
    end 

    it "will respond with a bad request error and error message per each invalid field of an invalid video" do 
      expect {
        # Act
        post videos_path, params: invalid_video

      # Assert
      }.wont_change "Video.count"
    
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"].keys).must_include "title"
      expect(body["errors"].keys).must_include "overview"
      expect(body["errors"].keys).must_include "release_date"
      expect(body["errors"].keys).must_include "total_inventory"
      expect(body["errors"].keys).must_include "available_inventory"
    end
  end 
end
