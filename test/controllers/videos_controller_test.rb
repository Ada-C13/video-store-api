require "test_helper"

describe VideosController do
  VIDEO_FIELDS_INDEX = ["id", "title", "release_date", "available_inventory"].sort
  VIDEO_FIELDS_SHOW = ["title", "overview", "release_date", "total_inventory", "available_inventory"].sort
  it "must get index" do
    get videos_path
    
    must_respond_with :success
    expect(response.header['Content-Type']).must_include 'json'
  end
  
  it "will return all the proper fields for videos" do
    
    get videos_path
    #gets body of response as array or hash
    body = JSON.parse(response.body)
    
    expect(body).must_be_instance_of Array
    
    body.each do |video|
      expect(video).must_be_instance_of Hash
      expect(video.keys.sort).must_equal VIDEO_FIELDS_INDEX
    end
  end
  
  it "returns an empty array if no videos exist" do
    Video.destroy_all
    
    get videos_path
    #gets body of response as array or hash
    body = JSON.parse(response.body)
    
    expect(body).must_be_instance_of Array
    expect(body.length).must_equal 0
    
  end
  
  describe "show" do
    it "will return a hash with the proper fields for an existing video" do
      
      video = videos(:firstvideo)
      
      get video_path(video.id)
      
      body = JSON.parse(response.body)
      
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal VIDEO_FIELDS_SHOW
    end
    
    it "will return a 404 request with json for a nonexistent video" do
      get video_path(-1)
      
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body['ok']).must_equal false
      expect(body['message']).must_equal 'Not found'
    end
  end
  
  describe "create" do
    
    
    let(:video_data) {
      {
        video: {
          title: "Video",
          overview: "a video is a video is a video",
          release_date: "11/11/1111",
          total_inventory: 13,
          available_inventory: 12
        }
      }
    }
    
    it "can create a new video" do
      expect { post videos_path, params: video_data }.must_differ "Video.count", 1
      must_respond_with :created
    end
    
    it "gives a bad_request status when user gives bad data" do
      video_data[:video][:title] = nil
      
      expect{ post videos_path, params: video_data }.wont_change "Video.count"
      must_respond_with :bad_request
      
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"].keys).must_include "title"
    end
    #TODO maybe include tests for other fields
    
  end
  
end
