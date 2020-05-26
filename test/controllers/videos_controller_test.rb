require "test_helper"

describe VideoController do
  it "will get all videos in json format" do
    get videos_path

    expect(response.header['Content-Type']).must_include 'json'
    must_respond_with :ok
   end

   describe "show" do 
    it "will show a video" do 

    end 

    it "will throw an error for a non existent video" do 

    end 
   end 
end
