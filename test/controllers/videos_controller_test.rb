require "test_helper"

describe VideosController do
  VIDEO_FIELD= ["overview", "title", "release_date", "available_inventory", "total_inventory"].sort
  it "must get index for videos" do 
    get videos_path

    must_respond_with :ok
    expect(response.header['Content-Type']).must_include 'json' 
  end
  it "will return all the proper fields a list of videos" do
  
   

    get videos_path

    body = JSON.parse(response.body)

    expect(body).must_be_instance_of Array
    body.each do |video|
      expect(video).must_be_instance_of Hash
      expect(video.keys.sort).must_equal VIDEO_FIELD
    end
  end
  it "will return an empty array if no videos exist" do 
    Video.destroy_all


    get videos_path

    body = JSON.parse(response.body)

    expect(body).must_be_instance_of Array
    expect(body.length).must_equal 0 

  end

  describe "show" do 
    it "will return a hash with the proper fields for an existing video" do 
      video = videos(:funny_video)

      get video_path(video.id)

      body = JSON.parse(response.body)
      must_respond_with :ok
      expect(response.header['Content-Type']).must_include 'json' 
      expect(body).must_be_instance_of Hash 
      expect(body.keys.sort).must_equal VIDEO_FIELD

    end
    it "will return a 404 request with a json for a non-existing video" do 

    end
  end
end
