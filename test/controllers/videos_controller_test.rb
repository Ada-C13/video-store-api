require "test_helper"

describe VideosController do
  let(:video) { videos(:Jumanji) }

  it "should get index" do
    get videos_url, as: :json
    must_respond_with :success
  end

  it "should show valid video" do
    get video_url(video.id), as: :json
    must_respond_with :success
  end

  it "should not show video with invalid id" do
    get video_url(-1), as: :json
    must_respond_with :not_found
  end

  describe "create" do
    let(:new_video) {
      {
        title: "Princess Mononoke",
        overview: "feral wolf-girl and relentless curse-boy save the forest spirit",
        release_date: "1997-12-12",
        total_inventory: 5
      }
    }
    
    it "should create video" do
      assert_difference("Video.count") do
        post videos_url, params: new_video , as: :json
      end

      must_respond_with :success
    end

    it "should not create movie with invalid params" do
      new_video[:title] = nil

      assert_no_difference("Video.count") do
        post videos_url, params: new_video , as: :json
      end
      must_respond_with :bad_request
    end

  end

end
