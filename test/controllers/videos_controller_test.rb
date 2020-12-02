require "test_helper"

describe VideosController do
  INDEX_FIELDS = ["id", "title", "release_date", "available_inventory"].sort
  SHOW_FIELDS = ["title", "overview", "release_date", "available_inventory", "total_inventory"].sort

  describe "index" do
    it "must get index" do
      get videos_path
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "will return proper fields for a list of videos" do
      get videos_path
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      
      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal INDEX_FIELDS
      end
    end

    it "returns empty array is no videos exist" do
      Video.destroy_all
      get videos_path
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0
    end
  end

  describe "show" do

    it "will return a hash with the proper fields for an existing video" do
      video = videos(:video_1)
      get video_path(video.id)
      body = JSON.parse(response.body)
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal SHOW_FIELDS
    end

    it "will return a 404 request with json for a non-existing video" do
        get video_path(-1)

        must_respond_with :not_found
        body = JSON.parse(response.body)
        expect(body).must_be_instance_of Hash
        expect(body['errors']).must_equal ['Not Found']
    end
  end

  describe "create" do 
    let(:video_params) {
        {
          title: "Blacksmith Of The Banished",
          overview: "The unexciting life of a boy will be permanently altered as a strange woman enters his life.",
          release_date: "1979-01-18",
          total_inventory: 10, 
          available_inventory: 9 
        }
    }
  
    it "can create a new video" do 
        
        expect { post videos_path, params: video_params }.must_differ "Video.count", 1 
        must_respond_with :created
    end 

    it "gives bad_request status when user gives bad data: video missing title" do 
      video_params[:title] = nil 

      expect {post videos_path, params: video_params}.wont_change "Video.count"
      must_respond_with :bad_request
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"].keys).must_equal ["title"]
    end

    it "gives bad_request status when user gives bad data: video missing overview" do 
      video_params[:overview] = nil 

      expect {post videos_path, params: video_params}.wont_change "Video.count"
      must_respond_with :bad_request
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"].keys).must_equal ["overview"]
    end

    it "gives bad_request status when user gives bad data: video missing release_date" do 
      video_params[:release_date] = nil 

      expect {post videos_path, params: video_params}.wont_change "Video.count"
      must_respond_with :bad_request
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"].keys).must_equal ["release_date"]
    end 

    it "gives bad_request status when user gives bad data: video missing available_inventory" do 
      video_params[:available_inventory] = nil 

      expect {post videos_path, params: video_params}.wont_change "Video.count"
      must_respond_with :bad_request
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"].keys).must_equal ["available_inventory"]
    end 

    it "gives bad_request status when user gives bad data: video missing total_inventory" do 
      video_params[:total_inventory] = nil 

      expect {post videos_path, params: video_params}.wont_change "Video.count"
      must_respond_with :bad_request
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"].keys).must_equal ["total_inventory"]
    end 
  end 

end
