require "test_helper"

describe VideosController do

  VIDEO_FIELDS = ["id", "title", "overview", "release_date", "total_inventory", "available_inventory"].sort
  let(:video) {videos(:test)}

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

end
