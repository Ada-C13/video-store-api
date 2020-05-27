require "test_helper"

describe VideosController do
  VIDEO_FIELDS = ['id', 'title', 'release_date', 'available_inventory', 'total_inventory', 'overview'].sort
  
  describe 'index' do
    it 'gets the index path' do
      get videos_path
      
      must_respond_with :success 
      
      expect(response.header['Content-Type']).must_include 'json'
      
    end
    
    it 'returns correct fields for the list of videos' do
      index_fields = ["available_inventory", "id", "release_date", "title"]
      get videos_path
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      
      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal index_fields
      end
    end
    
    it 'returns an empty array if there are no videos in the database' do
      Video.destroy_all 
      get videos_path
      
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0
      
    end
    
  end
  
  describe 'show' do
    it 'returns a hash with correct fields for an existing video' do
      show_fields = ["available_inventory", "overview", "release_date", "title", "total_inventory"]
      video = videos(:brazil)
      
      get video_path(video.id)
      
      body = JSON.parse(response.body)
      
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal show_fields
    end
    
    it 'returns a 404 response with JSON for a non-existant video' do
      get video_path('bad_id')
      
      must_respond_with :not_found
      
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Hash
      expect(body['errors']).must_equal ['Not Found']
    end
  end
  
  describe "create" do
    let(:video_data) {
      {
        video: {
          title: "A Cool Movie",
          release_date: "2020-01-02",
          available_inventory: 3,
          total_inventory: 3,
          overview: "The best movie you've ever seen"
        }
      }
    }
    
    it "can create a new video" do
      expect {
        post videos_path, params: video_data
      }.must_differ "Video.count", 1
      
      must_respond_with :created
    end
    
    it 'responds with bad request if field is empty' do
      video_data[:video][:title] = nil
      
      expect {
        post videos_path, params: video_data
      }.wont_differ "Video.count"
      
      must_respond_with :bad_request
    end
  end
end
