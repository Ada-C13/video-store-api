require "test_helper"

describe VideosController do
  VIDEO_FIELDS = ["id", "title", "release_date", "available_inventory"].sort

  describe "index" do 
    it "must get index" do
      get videos_path
      must_respond_with :success
  
      expect(response.header['Content-Type']).must_include 'json'
    end
  
    it "will return all the proper fields for a list of videos" do  
      # Act
      get videos_path
  
      body = JSON.parse(response.body)
  
      # Assert 
      expect(body).must_be_instance_of Array
  
      body.each do |video|
        expect(video).must_be_instance_of Hash 
        expect(video.keys.sort).must_equal VIDEO_FIELDS
      end
    end
  
  
    it "returns an empty array if no videos exist" do 
      Video.destroy_all 
  
      # Act
      get videos_path
  
      body = JSON.parse(response.body)
  
      # Assert 
      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0
    end
  end

  describe "show" do 
    # Nominal case
    it "will return a hash with the proper fields for an existing video" do 
      video = videos(:parasite)
      video_fileds = ["title", "overview", "release_date", "total_inventory", "available_inventory"].sort

      # Act
      get video_path(video.id)

      # Assert 
      must_respond_with :success

      body = JSON.parse(response.body)

      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash 
      expect(body.keys.sort).must_equal video_fileds
    end

    # Edge case 
    it "will return a 404 request with json for a non-existent video" do 
      get video_path(-1)

      must_respond_with :not_found 
      body = JSON.parse(response.body) 
      expect(body).must_be_instance_of Hash 
      expect(body['errors']).must_include 'Not Found'
    end
  end

  describe "create" do
    let(:video_data) {
      {
        title: "Parasite",
        overview: "This starts out almost like an 'Ocean's Eleven' heist film and then expands into a comedy, mystery, thriller, drama, romance, crime and even horror film.",
        release_date: "2019",
        total_inventory: 10,
        available_inventory: 5,
      }
    }

    it "can create a new video" do
      expect {
        post videos_path, params: video_data
      }.must_differ "Video.count", 1

      must_respond_with :created
    end

    it "will respond with bad_request for invalid data" do
      video_data[:title] = nil
      video_data[:total_inventory] = nil

      expect {
        # Act
        post videos_path, params: video_data

      # Assert
      }.wont_change "Video.count"
    
      must_respond_with :bad_request

      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      
      expect(body["errors"].keys).must_include "title"
      expect(body["errors"].keys).must_include "total_inventory"
    end
  end
end
