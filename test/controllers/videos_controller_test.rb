require "test_helper"

describe VideosController do
  REQUIRED_VIDEO_FIELDS = ['title', 'overview', 'release_date', "total_inventory", 'available_inventory'].sort
  
  def check_response(expected_type: ,expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe 'index' do
    it 'responds with JSON and success' do
      get videos_path

      check_response(expected_type: Array)
    end

    it 'responds with an array of video hashes' do
      get videos_path

      body = check_response(expected_type: Array)

      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal REQUIRED_VIDEO_FIELDS
      end
    end

    it 'will respond with an empty array when there are no videos' do
    
      Video.destroy_all

      get videos_path
      
      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end
  end

  describe 'create' do
    let(:video_data) {
      {
        video: {
          title: 'Harry Potter 3',
          overview: 'The best movie ever!',
          release_date: 2009-12-25,
          total_inventory: 10,
          available_inventory: 10
        }
      }
    }

    it 'can create a new video' do 
      expect {
        post videos_path, params: video_data
      }.must_differ 'Video.count', 1

      check_response(expected_type: Hash, expected_status: :created)
    end

    it 'will respond with bad_request for invalid data' do
      video_data[:video][:overview] = nil

      expect {
        post video_path, params: video_data
      }.wont_change "Video.count"
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"].keys).must_include 'overview'
    end
  end
  
end
