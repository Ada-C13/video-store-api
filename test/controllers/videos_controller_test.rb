require "test_helper"

describe VideosController do
  let(:video) { Video.new(
    title: "a", 
    overview: "this is a transformative movie", 
    release_date: "2020-01-01", 
    total_inventory: 20,
    available_inventory: 19
    ) }
    describe "video#index" do
      it "responds with success" do
        get videos_path
        must_respond_with :success
      end
      it "when no videos, responds with success and empty array" do
        Video.destroy_all
        get videos_path
        must_respond_with :success
        body = JSON.parse(response.body)
        expect(body).must_equal []
      end
      it "returns array of hashes, with expected attributes" do
        get videos_path
        body = JSON.parse(response.body)
        expect(body).must_be_instance_of Array
        video_attr = ["id", "title", "release_date", "available_inventory"]
        body.each do |video|
          expect(video).must_be_instance_of Hash
          expect(video.keys.sort).must_equal video_attr.sort
        end
      end
    end
  
    describe "video#create" do
      let(:good_video_data) { 
        {
          title: "Blacksmith Of The Banished",
          overview: "The unexciting life of a boy will be permanently altered as a strange woman enters his life.",
          release_date: "1979-01-18",
          total_inventory: 10,
          available_inventory: 9
        }
      }
      let(:bad_video_data) {
          {
            hello: "this is bad!",
            much: 5,
            ick: "not what I was expecting"
          }
      }
      
      it "responds with success when sent good data, successfully created new video" do
        expect {
          post videos_path, params: good_video_data
        }.must_differ "Video.count", 1
       
        must_respond_with :created
      end
      it "responds with failure when sent bad data" do
        post videos_path, params: bad_video_data
        must_respond_with :bad_request
      end
      # it "responds with failure when sent empty data set" do 
      #   expect{
      #     post videos_path, params: empty_video_data
      #   }.must_raise ActionController::ParameterMissing
      # end
  
    end
  
    describe "video#show" do
      it "responds with success with valid id" do
        first_video = Video.first
        get video_path(first_video.id)
        must_respond_with :success
      end
    end
end
