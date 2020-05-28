require "test_helper"

describe VideosController do
  VIDEO_FIELDS = ["id", "title", "overview", "release_date", "total_inventory", "available_inventory"].sort
  VIDEO_FIELDS_SHOW = ["title", "overview", "release_date", "total_inventory", "available_inventory"].sort
  
  describe "index" do
    it "will get all videos in json format" do
      get videos_path

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "will return an empty array if no videos" do 
      Video.destroy_all 
      get videos_path
      body = JSON.parse(response.body)
      expect(body).must_equal []
    end 
  end 
  describe "show" do 
    it "will show a video hash" do 

      video = videos(:vid1)
      get video_path(video.id)
      must_respond_with :success

      body = JSON.parse(response.body)

      expect(response.header["Content-Type"]).must_include 'json' 
      expect(body.keys.sort).must_equal VIDEO_FIELDS_SHOW
    end 

    it "will throw an error for a non existent video" do 

      get video_path(-1)

      must_respond_with :not_found

      body = JSON.parse(response.body) 

      expect(body).must_be_instance_of Hash
      expect(body["errors"][0]).must_equal "Not Found"

    end 
  end 

  describe "create" do 
    let (:video_data) {
      {
        title: "New Video", 
        overview: "new new new new create new new new", 
        release_date:  DateTime.now, 
        total_inventory: 7, 
        available_inventory: 3, 
      }
    }

    it "can create a new video" do 
        expect {
          post videos_path, params: video_data
      }.must_differ "Video.count", 1

      must_respond_with :created
    end 
  end 

end
