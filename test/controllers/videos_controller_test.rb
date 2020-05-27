require "test_helper"

describe VideosController do

  describe "index" do
    it "must get index" do
      get videos_path
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
    end
  
    it "will return all the proper fields for a list of videos" do
      video_fields = %w[id title release_date available_inventory].sort
      get videos_path
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal video_fields
      end
    end
  
    it "returns and empty array if no videos exist" do
      Video.destroy_all
      get videos_path
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0
    end
  end
  
  describe "show" do
    # nominal
    it "will return a hash with proper fields for an existing video" do
      video_fields = %w[title overview release_date total_inventory available_inventory].sort
      video = videos(:la_la_land)
      get video_path(video.id)
      

      must_respond_with :success

      body = JSON.parse(response.body)

      expect(response.header['Content-Type']).must_include 'json'

      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal video_fields
    end


    # edge
    it "will return a 404 request with json for a non-existant video" do
      get video_path(-1)
      
      must_respond_with :not_found
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      # expect(body['ok']).must_equal false
      expect(body['errors'][0]).must_equal 'Not Found'
    
    end
  end

end
