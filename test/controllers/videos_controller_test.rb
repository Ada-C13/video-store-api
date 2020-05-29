require "test_helper"

describe VideosController do
  it "must get index" do
    get videos_path

    must_respond_with :success

    expect(response.header['Content-Type']).must_include('json')
    must_respond_with :ok
  end


  it "will return a list of videos with proper fields" do 

    video_fields = ["id","title","release_date", "available_inventory"].sort 

    get videos_path 
    body = JSON.parse(response.body)

    expect(body).must_be_instance_of Array 

    body.each do |video|
      expect(video).must_be_instance_of Hash 
      expect(video.keys.sort).must_equal video_fields
    end 
  end 

  it "will return empty array and 200 status if no video" do 

    Video.destroy_all

    get videos_path 

    body = JSON.parse(response.body)

    expect(body).must_be_instance_of Array
    expect(body.length).must_equal 0 
    must_respond_with :ok
    
  end 

  describe 'show' do 

    it "will get show " do 
      video = Video.all.first

      get video_path(video.id)

      must_respond_with :ok 
      expect(response.header['Content-Type']).must_include('json')

    end 

    it "will return a pet " do 
      video = Video.all.first
      fields = ["title", "overview","release_date","total_inventory","available_inventory"].sort

      get video_path(video.id)

      must_respond_with :ok 
      expect(response.header['Content-Type']).must_include('json')

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Hash 
      expect(body["title"]).must_equal "testvideo"

    end 

    it "will show not_fond and error if no video" do 
      get video_path(-1)

      body = JSON.parse(response.body)

      must_respond_with :not_found
      expect(body).must_be_instance_of Hash


      expect(body["errors"]).must_include "Not Found"
    end 
  end 

  describe 'create' do
    let(:video_data) {
      {
        title: "testtitle",
        overview: "something",
        release_date: "2019-03-02",
        total_inventory: 10 ,
        available_inventory: 5 
      }
    } 


    it "can post a new video" do 

      expect{ post videos_path, params: video_data}.must_differ "Video.count", 1
      must_respond_with :created 

    end 


    it "will return errors if invalid input of video" do 
      video_data[:title] = nil 

      expect{post videos_path, params: video_data}.wont_change "Video.count" 
      must_respond_with :bad_request 

      expect(response.header['Content-Type']).must_include('json')
      body = JSON.parse(response.body)
      expect(body["errors"].keys).must_include "title"

    end 
  end 

end


