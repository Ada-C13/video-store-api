require "test_helper"

describe VideosController do

  describe "index" do 
    it "responds with JSON and success" do
      get videos_path

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "responds with an array of video info" do
      get videos_path

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Array

      body.each do |video|
        expect(video).must_be_instance_of Hash
        required_attrs = ["title", "overview", "release_date", "total_inventory", "available_inventory"]
        expect(video.keys.sort).must_equal required_attrs.sort
      end
    end

    it "will give back an empty array if no videos" do
      Video.destroy_all

      get videos_path
      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Array
      expect(body).must_be_empty
    end
  end

end
