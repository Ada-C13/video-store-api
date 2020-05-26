require "test_helper"

describe VideosController do
  VIDEO_FIELDS = ["id", "title", "overview", "release_date", "total_inventory", "available_inventory"].sort

  it "will get all videos in json format" do
    get videos_path

    expect(response.header['Content-Type']).must_include 'json'
    must_respond_with :ok
  end

  it "will return an empty array if no videos" do 


  end 

   describe "show" do 
      it "will show a video hash" do 

        video = videos(:vid1)
        get video_path(video.id)
        must_respond_with :success

        body = JSON.parse(response.body)

        expect(response.header["Content-Type"]).must_include 'json' 
        expect(body.keys.sort).must_equal VIDEO_FIELDS
      end 

      it "will throw an error for a non existent video" do 

        get video_path(-1)

        must_respond_with :not_found

        body = JSON.parse(response.body) 

        expect(body).must_be_instance_of Hash

        expect(body["ok"]).must_equal false

      end 


    end 
end
