require "test_helper"

describe VideosController do
  let(:video) { videos(:one) }

  it "should get index" do
    get videos_url, as: :json
    must_respond_with :success
  end

  it "should create video" do
    value do
      post videos_url, params: { video: {  } }, as: :json
    end.must_differ "Video.count"

    must_respond_with 201
  end

  it "should show video" do
    get video_url(@video), as: :json
    must_respond_with :success
  end

  it "should update video" do
    patch video_url(@video), params: { video: {  } }, as: :json
    must_respond_with 200
  end

  it "should destroy video" do
    value do
      delete video_url(@video), as: :json
    end.must_differ "Video.count", -1

    must_respond_with 204
  end
end
