require "test_helper"

describe VideosController do
  INDEX_VIDEO_FIELDS = ["id", "title", "release_date", "available_inventory"].sort

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do
    it "responds with JSON and success" do
      get videos_path
      check_response(expected_type: Array)
    end
  end
end
