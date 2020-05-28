require "test_helper"

describe VideosController do
  it "must get index for videos" do 
    get videos_path

    must_respond_with :ok
    expect(response.header['Content-Type']).must_include 'json' 
  end
  it "will return all the proper fields a list of videos" do
    video_fields = ["id", "title", "release_date", "available_inventory"].sort

    get videos_path

    body = JSON.parse(response.body)

    expect(body).must_be_instance_of Array
    body.each do |video|
      expect(video).must_be_instance_of Hash
      expect(video.keys.sort).must_equal video_fields
    end
  end
  it "will return an empty array if no videos exist" do 
    Video.destroy_all


    get videos_path

    body = JSON.parse(response.body)

    expect(body).must_be_instance_of Array
    expect(body.length).must_equal 0 

  end
end
