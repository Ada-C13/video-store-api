require "test_helper"

describe VideosController do

  VIDEO_FIELDS = ["id", "title", "overview", "release_date", "total_inventory", "available_inventory"].sort
  let(:video) {videos(:video_1)}

  describe "index" do
    it "list all the videos" do
      get videos_path
      must_respond_with :success
    end

    it "return json" do
      get videos_path
      expect (response.header["Content-Type"]).must_include "json"
    end

    it "return an Array" do
      get videos_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all the proper fields for the videos" do
      get videos_path

      body = JSON.parse(response.body)
      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal VIDEO_FIELDS
      end
    end

    it "returns all the videos" do
      get videos_path

      body = JSON.parse(response.body)
      body.length.must_equal Video.count
    end

    it "return empty array if there is 0 customers" do
      Video.destroy_all

      get videos_path

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0
    end
  end

  describe "show" do
    it "will show one video" do
      get videos_path(video)
      must_respond_with :success
    end

    it "returns a Hash w/the right fields for existing video" do
      video = videos(:video_1)

      get video_path(video.id)

      must_respond_with :success

      body = JSON.parse(response.body)

      expect(response.header["Content-Type"]).must_include "json"  

      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal VIDEO_FIELDS
    end

    it "will give error for inexistent video" do
      get video_path(-1)
      must_respond_with :not_found

      body = JSON.parse(response.body)

      expect(body).must_include "errors"
      expect(body["errors"][0]).must_equal "Not Found"
    end
  end

  # describe "create" do
  #   let(:video_data){
  #     {
  #       title: "Petty worman",
  #       overview: "about a girl's dream",
  #       release_date: 1985
  #       available_inventory:
  #       total_inventory: 
  #     }
  #   }
  # end


    













  

end
