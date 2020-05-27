require "test_helper"

describe VideosController do
  VIDEO_FIELDS = ["id", "title", "overview", "release_date", "total_inventory", "available_inventory"].sort

  it "must get index" do
    get videos_path

    must_respond_with :success
    expect(response.header['Content-Type']).must_include 'json'
  end

  it "will return all the proper fields for a list of videos" do

    get videos_path

    body = JSON.parse(response.body)

    expect(body).must_be_instance_of Array

    body.each do |video|
      expect(video).must_be_instance_of Hash
      expect(video.keys.sort).must_equal VIDEO_FIELDS
    end
  end

  it "returns an empty array if no videos exist" do
    Video.destroy_all

    get videos_path

    body = JSON.parse(response.body)
 
    expect(body).must_be_instance_of Array
    expect(body.length).must_equal 0
  end

  describe "show" do
    # Nominal
    it "for an existing video will return a hash with the proper fields" do
      video = videos(:video1)

      get video_path(video.id)

      must_respond_with :success

      body = JSON.parse(response.body)

      expect(response.header['Content-Type']).must_include 'json'

      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal VIDEO_FIELDS
    end

    # Edge Case
    it " for a non-existent video will return a 404 request with json" do
      get video_path(-1)

      must_respond_with :not_found
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body['ok']).must_equal false
      expect(body['message']).must_equal 'Not found'
    end
  end

  describe "create" do
    let (:video_params){
        {video: { 
          title: "video1",
          overview: "Somthing", 
          release_date: "1979-01-18", 
          total_inventory: 10,
          available_inventory: 9,
        }
      }
    }
  
    it "can create new video" do
      expect{ post videos_path, params: video_params}.must_differ "Video.count", 1
      must_respond_with :created
    end

    it "gives bad_request status when user doesn't adding all the feeled" do
      video_params[:video][:title] = nil
      video_params[:video][:overview] = nil
      video_params[:video][:release_date] = nil
      video_params[:video][:total_inventory] = nil
      video_params[:video][:available_inventory] = nil
      
      expect{ post videos_path, params: video_params}.wont_change "Video.count"
      must_respond_with :bad_request

      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body['errors'].keys).must_include "title"
      expect(body['errors'].keys).must_include "overview"
      expect(body['errors'].keys).must_include "release_date"
      expect(body['errors'].keys).must_include "total_inventory"
      expect(body['errors'].keys).must_include "available_inventory"
    end
  end

end
