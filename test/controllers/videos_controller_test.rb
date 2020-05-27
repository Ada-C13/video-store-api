require "test_helper"
require "date"

describe VideosController do

  REQUIRED_VIDEO_FIELDS = ["id", "title", "release_date", "available_inventory"].sort

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
      # expect(response.header['Content-Type']).must_include 'json'
      # must_respond_with :ok
      check_response(expected_type: Array)
    end

    it "responds with an array of Video hashes" do
      # Act 
      get videos_path

      # Get the body of the response
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_instance_of Array

      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.keys.sort).must_be REQUIRED_VIDEO_FIELDS
      end
    end
    
    it "will respond with an empty array when there are no Videos" do
      # Arrange
      Video.destroy_all

      # Act
      get videos_path
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_instance_of Array
      expect(body).must_equal []
    end 

  end


  describe "show" do
    before do 
      video = Video.new(
          "title": "Joker",
          "overview": "Movie about a sad clown",
          "release_date": Date.today,
          "total_inventory": 5,
          "available_inventory": 1
      )
      video.save
    end 

    it "responds with JSON, success, and video data when looking for one existing video" do
      # Arrange
      existing_video = Video.first

      #Act
      get video_path(existing_video.id)
      body = check_response(expected_type: Hash)

      # Assert
      expect(body.keys.sort).must_equal REQUIRED_VIDEO_FIELDS

      expect(body["id"]).must_equal existing_video.id
      expect(body["title"]).must_equal existing_video.title
      expect(body["release_date"]).must_equal existing_video.release_date.strftime("%Y-%m-%d") # TODO: convert to string; .strftime("")
      expect(body["available_inventory"]).must_equal existing_video.available_inventory
    end
  
    it "responds with JSON, not found, and errors when looking for non-existent video" do
      get video_path(-1)

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["ok"]).must_equal false
      expect(body["errors"]).must_include "Not Found"
    end
  end

  describe "create" do 
    let (:valid_video){
      {
        video: {
          title: "Joker",
          overview: "Movie about a sad clown",
          release_date: Date.today,
          total_inventory: 5,
          available_inventory: 1
        }
      }
    }

    let (:invalid_video){
      {
        video: {
          title: nil,
          overview: "movie with no title",
          release_date: Date.today,
          total_inventory: 5,
          available_inventory: 1
        }
      }
    }
  
    it "can create a new video" do 
      expect {
        post videos_path, params: valid_video
      }.must_differ "Video.count", 1

      check_response(expected_type: Hash, expected_status: :created)
    end 

    it "will respond with a bad request for invalid data" do 
      expect {
        # Act
        post videos_path, params: invalid_video

      # Assert
      }.wont_change "Video.count"
    
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"].keys).must_include "title"
    end
  end 
end
