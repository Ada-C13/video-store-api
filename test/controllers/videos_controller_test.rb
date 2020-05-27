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
      get videos_path
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      
      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal VIDEO_FIELDS
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
      video = videos(:brazil)
      
      get video_path(video.id)
      
      body = JSON.parse(response.body)
      
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal VIDEO_FIELDS
    end
    
    it 'returns a 404 response with JSON for a non-existant video' do
      get video_path('bad_id')
      
      must_respond_with :not_found
      
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Hash
      expect(body['ok']).must_equal false
      expect(body['message']).must_equal 'Not found'
    end
  end
  
  
end
